package Multiplier

import chisel3._
import chisel3.util._

trait BaseData {
  val w = 65
  val odd: Boolean = w % 2 == 1
  val n: Int = if (odd) (w + 1) / 2 else w / 2

}

trait Topology extends BaseData {
  val connectCompressor: Seq[Int] = Seq(0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 13, 13, 13, 0)
  val connectCompressorSorted: Seq[(Int, Int)] = connectCompressor.zipWithIndex.sortBy(c => c._2)
  val outArray: Seq[Int] = Seq(0, 1, 1, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 17, 18)
  val inputArray: Seq[Int] = Seq(8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19)
  val sOrCaOutArray: Seq[Int] = Seq(3, 1, 2, 3, 3, 1, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 3, 3, 1, 2, 3, 3, 3)

  //  val connectLayer = for (c <- connectCompressor; i <- 0 until  layer.length - 1) {
  //    if(c >= layer(i) && c <= layer(i + 1)) yield i
  //    else
  //  }
  require(outArray.length == inputArray.length && outArray.length == sOrCaOutArray.length)

  // ((from where, connect type), to where)
  val topologyArray: Seq[((Int, Int), Int)] = outArray.zip(sOrCaOutArray).zip(inputArray)
  val compressorNum: Int = inputArray.last + 1
  var connectArray: Seq[((Int, Int), Int)] = for (c <- connectCompressor.zipWithIndex) yield ((-c._2 - 1, 1), c._1)
  connectArray ++= topologyArray
  val topologyAll = connectArray.sortBy(x => x._2)
  //  def CompressorList: Seq[Int] = {
  //    val compressorList = Seq.fill(compressorNum)(0)
  //    for (i <- connectCompressor.indices) {
  //      compressorList(connectCompressor(i)) += 1
  //    }
  //    for (j <- inputArray.zip(sOrCaOutArray)) {
  //      compressorList(j._1) += (if (j._2 == 3) 2 else 1)
  //    }
  //    compressorList
  //  }
}