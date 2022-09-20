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
  var connectArray: Seq[((Int, Int), Int)] = for (c <- ppToCompressor.zipWithIndex) yield ((-c._2 - 1, 1), c._1)
  connectArray ++= topologyArray

  val topologyAll: Seq[((Int, Int), Int)] = connectArray.sortBy(x => x._2)


  val layer: Seq[Seq[Int]] = if (autoGenArray) genLayers()._1 else layerCustom

  val pipeline: Seq[(Int, Int)] = Seq((1, 0), (4, 1))
  val isLastLayerPipe: Boolean = (pipeline.last._1 == layer.length - 1) && isPipeline

//  private def genTopologyArray (autoGen: Boolean): Seq[((Int, Int), Int)] = {
//    if (!autoGen)
//      outArray.zip(sOrCaOutArray).zip(inputArray)
//    else {
//      val (layers: Seq[Seq[Int]], choseCompressor: Seq[Int], remains: Seq[Int]) = genLayers()
//      val layerNum = layers.length
////      require(layerNum >= (log2Ceil(ppNum) - 1), "Layer number is too SMALL")
////      require(layerNum <= (math.ceil(math.log(ppNum) / math.log(1.5)) - 1), "Layer number is too LARGE")
//      val connectCompressorAuto = Seq()
//      for (i <- 0 until layerNum) {
//        if (i == 0) {
//          var index = -1
//          var count = 1
//          val r = genLayers._3.head
//          for (j <- 0 until ppNum) {
//
//          }
//        }
//      }
//    }
//  }

  private def genLayers(): (Seq[Seq[Int]], Seq[Int], Seq[Int]) = {
    val remains: Seq[Int] = Seq()
    remains ++ Seq(ppNum)
    val choseCompressor: Seq[Int] = Seq()
    val compressorNum: Seq[Int] = Seq()
    val noConnected: Seq[Int] = Seq()
    var i = 0
    while(remains(i) > 2) {
      val r = remains(i)
      val c = choseCompressor(r)
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
    (layer, choseCompressor, remains)
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
