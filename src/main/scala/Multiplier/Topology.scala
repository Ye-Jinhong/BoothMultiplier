package Multiplier

import chisel3.util._

trait BaseData {
  val w = 65
  val odd: Boolean = w % 2 == 1
  val isPipeline: Boolean = true
  val n: Int = if (odd) (w + 1) / 2 else w / 2
  val ppNum: Int = n + 2
  // If you use the auto generation function for topology
  // The following variables should be correct
  // Otherwise they do not matter
  val autoGenArray: Boolean = false
//  val layerNum: Int = 5
}

trait Customize extends BaseData{
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
}

trait Topology extends Customize {
  // ((from where, connect type), to where)
  val topologyArray: Seq[((Int, Int), Int)] = outArray.zip(sOrCaOutArray).zip(inputArray)
  val compressorNum: Int = inputArray.last + 1

  // ((from where, connect type), to where)
  // When data comes from PP, then its index = -1 - 1
  // for example PP1: ((-2, 1) 0). It's from -2.
  var connectArray: Seq[((Int, Int), Int)] = for (c <- ppToCompressor.zipWithIndex) yield ((c._2 - ppNum, 1), c._1)
  connectArray ++= topologyArray

  val topologyAll: Seq[((Int, Int), Int)] = connectArray.sortBy(x => x._2)


  val layer: Seq[Seq[Int]] = if (autoGenArray) genLayers()._1 else layerCustom

  val pipeline: Seq[(Int, Int)] = Seq((1, 0), (4, 1))
  val isLastLayerPipe: Boolean = (pipeline.last._1 == layer.length - 1) && isPipeline

  private def genTopology (autoGen: Boolean): Seq[((Int, Int), Int)] = {
    if (!autoGen) {
      val topologyArray: Seq[((Int, Int), Int)] = outArray.zip(sOrCaOutArray).zip(inputArray)
      val connectArray: Seq[((Int, Int), Int)] = for (c <- ppToCompressor.zipWithIndex) yield ((-c._2 - 1, 1), c._1)
      connectArray ++ topologyArray
    } else {
      val (layers: Seq[Seq[Int]], choseCompressor: Seq[Int], remains: Seq[Int], noConnected: Seq[Int]) = genLayers()
      val layerNum = layers.length
      val connectCompressorAuto = Seq()
      // (from where, to where, connect type, is connected)
      var connectedWire: Seq[(Int, Int, Int, Boolean)] = Seq()
      var noConnectedWire: Seq[(Int, Int, Int, Boolean)] = Seq()
      val pp2c0 = for (i <- 0 until ppNum - 1) yield (i - ppNum, 0, 1, false)
      pp2c0 ++ Seq((-1, 0, 1, false))
      noConnectedWire = pp2c0.sortBy(i => (i._4, i._1, i._3))

      for (i <- 0 until layerNum) {
        val layerIndex = layerNum - i - 1
        if(layerIndex == 0){

        } else {
          val layerDown = layers(i)
          val layerUp = layers(i - 1)
          val cNumDown = layerDown.length
          val cNumUp = layerUp.length
          val noConnect = noConnected(i - 1)
          for (j <- layerUp.indices){

          }
        }
      }
    }
  }

  private def genConnection(noConnectedWire: Seq[(Int, Int, Int, Boolean)],
                            connectedWire: Seq[(Int, Int, Int, Boolean)],
                            cType: Int, compressors: Seq[Int]): Seq[(Int, Int, Int, Boolean)] = {
    var noConnectedLine = noConnectedWire.sortBy(i => (i._4, i._1, i._3))
    var connectedLine = connectedWire
    var counter = 0
    for (i <- compressors) {
    }
  }

//  private def genPPToCompressor(cType: Int, noConnect: Int): Seq[((Int, Int), Int)] ={
//    if(!autoGenArray)
//      connectArray
//    else{
//      val pp2c0 = for (i <- 0 until ppNum - 1) yield (-i - 1, i + 1)
//      pp2c0 ++ Seq((ppNum - 1, 0))
//      val pp2c1 = pp2c0.sortBy(i => i._2)
//      var c = 0
//      for (i <- pp2c1.indices) {
//        if (i <= ppNum - 1 - noConnect) {
//
//        } else {
//
//        }
//      }
//    }
//  }
  private def genLayers(): (Seq[Seq[Int]], Seq[Int], Seq[Int], Seq[Int]) = {
    val remains: Seq[Int] = Seq()
    remains ++ Seq(ppNum)
    val choseCompressor: Seq[Int] = Seq()
    val compressorNum: Seq[Int] = Seq()
    val noConnected: Seq[Int] = Seq()
    var i = 0
    while(remains(i) > 2) {
      val r = remains(i)
      val c = chooseCompressor(r)
      val cNum = r / c
      choseCompressor ++ Seq(c)
      compressorNum ++ Seq(cNum)
      remains ++ Seq(cNum * 2 + (r % c))
      noConnected ++ Seq(r % c)
      i = i + 1
    }
    require(remains.last == 2)
    val layer: Seq[Seq[Int]] = Seq()
    var index = 0
    for (i <- compressorNum) {
      val l: Seq[Int] = Seq()
      for (j <- 0 until i) {
        l ++ Seq(index)
        index = index + 1
      }
      layer ++ Seq(l)
    }
    (layer, choseCompressor, remains, noConnected)
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
//
//}

//trait Topology extends BaseData {
//  val connectCompressor: Seq[Int] = Seq(0, 0, 1, 1, 1, 0)
//  val connectCompressorSorted: Seq[(Int, Int)] = connectCompressor.zipWithIndex.sortBy(c => c._2)
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
//  var connectArray: Seq[((Int, Int), Int)] = for (c <- connectCompressor.zipWithIndex) yield ((-c._2 - 1, 1), c._1)
//  connectArray ++= topologyArray
//  val topologyAll = connectArray.sortBy(x => x._2)
//
//  val layer: Seq[Seq[Int]] = Seq(
//    Seq(0, 1),
//    Seq(2))
//}
