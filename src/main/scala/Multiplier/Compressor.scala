package Multiplier

import chisel3._
import chisel3.util._

import scala.:+

class Compressor extends Topology {
  val layer: Seq[Seq[Int]] = Seq(
    Seq(0, 1, 2, 3, 4, 5, 6, 7),
    Seq(8, 9, 10, 11, 12, 13),
    Seq(14, 15, 16),
    Seq(17, 18),
    Seq(19))
  val layerNum: Int = layer.length

  def genLayer(n: Int, input: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    // topology -> ((from where, connect type), to where)
    // input -> (value, from where)
    val compressorIndex: Seq[Int] = layer(n)
    val t: Seq[((Int, Int), Int)] = topologyAll.filter(t => compressorIndex.contains(t._2))
    val remains = input.filter(x => !compressorIndex.contains(x._2))
    genCompressor(compressorIndex.head, compressorIndex.last, input, t) ++ remains
  }

  def genCompressor(a: Int, b: Int, input: Seq[(Value, Int)], topology: Seq[((Int, Int), Int)]): Seq[(Value, Int)] = {
    // topology -> ((from where, connect type), to where)
    // input -> (value, from where)
    // return -> (value, from where)
    require(a <= b)
    if (a == b) {
      // to Compressor a
      val in0 = for (c <- topology if c._2 == a) yield c
      println(s"$in0")

      // index where inputs from
      val in1 = for (i <- in0 if i._1._2 == 1) yield i._1._1
      println(s"$in1")
      val in2 = for (i <- in0 if i._1._2 == 2) yield i._1._1
      println(s"$in2")
      val in3 = for (i <- in0 if i._1._2 == 3) yield i._1._1
      println(s"$in3")
      var in: Seq[Value] = Seq()
      for (i <- in1) {
        in = in :+ input.filter(x => x._2 == i).head._1
      }
      for (i <- in2) {
        in = in :+ input.filter(x => x._2 == i).last._1
      }
      for (i <- in3) {
        in = (for (x <- input if x._2 == i) yield x._1) ++ in
      }
      val outs = Compressor(in)
      for (i <- outs.toVec) yield (i, a)
    } else {
      genCompressor(a, b - 1, input, topology) ++ genCompressor(b, b, input, topology)
    }
  }
}


object Compressor {
  def apply(in: Seq[Value]): CompressorOutput = {
    println(s"length = ${in.length}")
    require(in.length == 3 || in.length == 4)
    if (in.length == 3) Compressor32(in)
    else Compressor42(in)
  }

  def apply(in: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    val compressorLayer = new Compressor
    var outputs: Seq[(Value, Int)] = in
    for (i <- 0 until compressorLayer.layerNum) {
      outputs = compressorLayer.genLayer(i, outputs)
    }
    outputs
  }
}