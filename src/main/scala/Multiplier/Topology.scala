package Multiplier

import chisel3.util._

trait BaseData {
  val w = 65
  val odd: Boolean = w % 2 == 1
  val isPipeline: Boolean = true
  val n: Int = if (odd) (w + 1) / 2 else w / 2
  val ppNum: Int = n + 2
  // If you want to use Auto Generation
  // Please use `ture` to replace `false`
  val autoGenArray: Boolean = true
}

trait Customize extends BaseData{
  // If you do not use the auto generation function for topology
  // The following variables should be correct
  // Otherwise they do not matter
  val ppToCompressor: Seq[Int] = Seq(0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 13, 13, 13, 0)
  val outArray: Seq[Int] = Seq(0, 1, 1, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 17, 18)
  val inputArray: Seq[Int] = Seq(8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19)
  val sOrCaOutArray: Seq[Int] = Seq(3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3)

  require(outArray.length == inputArray.length && outArray.length == sOrCaOutArray.length)

  val layerCustom: Seq[Seq[Int]] = Seq(
    Seq(0, 1, 2, 3, 4, 5, 6, 7),
    Seq(8, 9, 10, 11, 12, 13),
    Seq(14, 15, 16),
    Seq(17, 18),
    Seq(19))

  val cTypesCustom: Seq[Int] = Seq( 4, 4, 4, 4, 4, 4)
}

trait Topology extends Customize {

  val layerOut: (Seq[Seq[Int]], Seq[Int]) = genLayers(cTypesCustom)
  val layer: Seq[Seq[Int]] = layerOut._1
  val cTypes: Seq[Int] = layerOut._2
//  println(cTypes)

  val topologyAll: Seq[((Int, Int), Int)] = genTopology()

  val pipeline: Seq[(Int, Int)] = Seq((1, 0), (4, 1))
  val isLastLayerPipe: Boolean = (pipeline.last._1 == layer.length - 1) && isPipeline

  private def genTopology (): Seq[((Int, Int), Int)] = {
    if (!autoGenArray) {
      // ((from where, connect type), to where)
      val topologyArray: Seq[((Int, Int), Int)] = outArray.zip(sOrCaOutArray).zip(inputArray)
      var connectArray: Seq[((Int, Int), Int)] = for (c <- ppToCompressor.zipWithIndex) yield ((c._2 - ppNum, 1), c._1)
      connectArray ++= topologyArray
      connectArray
    } else {
      // (from where, from layer, to where, connect type, is connected)
      var noConnectedWire: Seq[(Int, Int, Int, Int, Boolean)] = Seq()
      var pp2C = for (i <- 0 until ppNum - 1) yield (i - ppNum, -2, 0, 1, false)
      pp2C ++= Seq((-1, -1, 0, 1, false))
      noConnectedWire = pp2C.sortBy(i => (i._2, i._5, i._1, i._4))

      val topology = genConnection(noConnectedWire, 0)
      for (i <- topology) yield ((i._1, i._3), i._2)
    }
  }

  private def genConnection(noConnectedWire: Seq[(Int, Int, Int, Int, Boolean)], nowLayer: Int): Seq[(Int, Int, Int)] = {
    // (from where, from layer, to where, connect type, is connected)
    var noConnectedLine = noConnectedWire.sortBy(i => (-i._2, i._5, i._1, i._4))
    var connectedLine: Seq[(Int, Int, Int)] = Seq()
    var noConnectedLineOut: Seq[(Int, Int, Int, Int, Boolean)] = Seq()
    val cType = cTypes(nowLayer)
    var counter = 0
    var c = 0
    val cNum = layer(nowLayer).last - layer(nowLayer).head
    for (i <- noConnectedLine.indices) {
      if (c <= cNum) {
        val line = noConnectedLine(i)
        // (from where, from layer, to where, connect type, is connected)
        val updateLine = (line._1, line._2, layer(nowLayer)(c), line._4, true)
        noConnectedLine = noConnectedLine.updated(i, updateLine)
        connectedLine ++= Seq((updateLine._1, updateLine._3, updateLine._4))
        counter = counter + 1
        if (counter % cType == 0) {
          val out1 = (layer(nowLayer)(c), nowLayer, 0, 1, false)
          val out2 = (layer(nowLayer)(c), nowLayer, 0, 2, false)
          noConnectedLineOut ++= Seq(out1, out2)
          c = c + 1
          counter = 0
        }
      }
    }

    val noConnect0 = noConnectedLine.filter(c => !c._5)
    noConnectedLineOut ++= noConnect0

    if (nowLayer < layer.length - 1) {
      connectedLine ++= genConnection(noConnectedLineOut, nowLayer + 1)
      connectedLine
    } else {
      connectedLine
    }
  }


  private def genLayers(cTypes: Seq[Int]): (Seq[Seq[Int]], Seq[Int]) = {
    if (!autoGenArray) {
      (layerCustom, cTypesCustom)
    } else {
      val givenCNum = cTypes.length
      var remains: Seq[Int] = Seq()
      remains ++= Seq(ppNum)
      var choseCompressor: Seq[Int] = Seq()
      var compressorNum: Seq[Int] = Seq()
      var i = 0
      while (remains(i) > 2) {
        val r = remains(i)
        val c = if (i < givenCNum && cTypes(i) <= r) cTypes(i) else chooseCompressor(r)
        val cNum = r / c
        choseCompressor ++= Seq(c)
        compressorNum ++= Seq(cNum)
        remains ++= Seq(cNum * 2 + (r % c))
        i = i + 1
      }
      require(remains.last == 2)
      var layer: Seq[Seq[Int]] = Seq()
      var index = 0
      for (i <- compressorNum) {
        var l: Seq[Int] = Seq()
        for (j <- 0 until i) {
          l ++= Seq(index)
          index = index + 1
        }
        layer ++= Seq(l)
      }
      (layer, choseCompressor)
    }
  }


  private def chooseCompressor(num: Int): Int = {
    if (num % 4 == 0)
      4
    else if (num % 3 == 0)
      3
    else if(num % 4 == 3)
      3
    else
      4
  }
}


//trait BaseData {
//  val w = 8
//  val odd: Boolean = w % 2 == 1
//  val n: Int = if (odd) (w + 1) / 2 else w / 2
//  val ppNum: Int = n + 2
//  val isPipeline = false
//}
//
//trait Topology extends BaseData {
//  val ppToCompressor: Seq[Int] = Seq(0, 0, 1, 1, 1, 0)
//  val connectCompressorSorted: Seq[(Int, Int)] = ppToCompressor.zipWithIndex.sortBy(c => c._2)
//  val outArray: Seq[Int] = Seq(0, 1)
//  val inputArray: Seq[Int] = Seq(2, 2)
//  val sOrCaOutArray: Seq[Int] = Seq(3, 3)
//
//  //  val connectLayer = for (c <- connectCompressor; i <- 0 until  layer.length - 1) {
//  //    if(c >= layer(i) && c <= layer(i + 1)) yield i
//  //    else
//  //  }
//  require(outArray.length == inputArray.length && outArray.length == sOrCaOutArray.length)
//
//  // ((from where, connect type), to where)
//  val topologyArray: Seq[((Int, Int), Int)] = outArray.zip(sOrCaOutArray).zip(inputArray)
//  val compressorNum: Int = inputArray.last + 1
//  var connectArray: Seq[((Int, Int), Int)] = for (c <- ppToCompressor.zipWithIndex) yield ((-c._2 - 1, 1), c._1)
//  connectArray ++= topologyArray
//  val topologyAll = connectArray.sortBy(x => x._2)
//
//  val layer: Seq[Seq[Int]] = Seq(
//    Seq(0, 1),
//    Seq(2))
//
//  val pipeline: Seq[(Int, Int)] = Seq((1, 0), (4, 1))
//  val isLastLayerPipe: Boolean = (pipeline.last._1 == layer.length - 1) && isPipeline
//}
