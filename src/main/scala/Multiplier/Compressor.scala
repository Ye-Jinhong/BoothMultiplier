package Multiplier

import chisel3._
import chisel3.util._


class Compressor extends Topology {
  val layerNum: Int = layer.length

  def genLayer(l: Int, input: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    // topology -> ((from where, connect type), to where)
    // input -> ((value, from where), not used)
    val compressorIndex: Seq[Int] = layer(l)
    val t: Seq[((Int, Int), Int)] = topologyAll.filter(t => compressorIndex.contains(t._2))
    genCompressor(compressorIndex.head, compressorIndex.last, input, t)
  }

  def genCompressor(a: Int, b: Int, input: Seq[(Value, Int)], topology: Seq[((Int, Int), Int)]): Seq[(Value, Int)] = {
    // topology -> ((from where, connect type), to where)
    // input -> (value, from where)
    // return -> (value, from where)
    require(a <= b)
    if (a == b) {
      // to Compressor a
      // t0 -> ((from where, connect type), to where)
      val t0 = for (c <- topology if c._2 == a) yield c
      val inputIndex: Seq[((Value, Int), Int)] = input.zipWithIndex

      // index where inputs from
      val in1 = for (i <- t0 if i._1._2 == 1) yield i._1._1
      val in2 = for (i <- t0 if i._1._2 == 2) yield i._1._1
      val in3 = for (i <- t0 if i._1._2 == 3) yield i._1._1
      var in: Seq[Value] = Seq()
      var inIndex: Seq[Int] = Seq()
      var inRemains: Seq[(Value, Int)] = Seq()

      for (i <- in1) {
        in = in :+ input.filter(x => x._2 == i).head._1
        inIndex = inIndex :+ inputIndex.filter(x => x._1._2 == i).head._2
      }
      for (i <- in2) {
        in = in :+ input.filter(x => x._2 == i).last._1
        inIndex = inIndex :+ inputIndex.filter(x => x._1._2 == i).last._2
      }
      for (i <- in3) {
        in = (for (x <- input if x._2 == i) yield x._1) ++ in
        inIndex = (for(x <- inputIndex if x._1._2 == i) yield x._2) ++ inIndex
      }
//      in.foreach(x => printf(p"in = ${x.value}, ${x.offset}\n"))
//      printf(p"in = ${in}\n")
      val outs = Compressor(in)
//      printf(p"offsets = ${outs.s.offset}\n")
//      printf(p"offsetca = ${outs.ca.offset}\n")
      inRemains = for(i <- inputIndex if !inIndex.contains(i._2)) yield i._1
//      printf(p"length of inRemains = ${inRemains.length}\n")
      (for (i <- outs.toSeq) yield (i, a)) ++ inRemains
    } else {
      val inRemains = genCompressor(b, b, input, topology)
//      printf(p"length of inRemains = ${inRemains.length}\n")
      genCompressor(a, b - 1, inRemains, topology)
    }
  }
}


object Compressor {
  def apply(in: Seq[Value]): CompressorOutput = {
//    println(s"length = ${in.length}\n")
    require(in.length == 3 || in.length == 4)
    if (in.length == 3) Compressor32(in)
    else Compressor42(in)
  }

  def apply(in: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    val compressorLayer = new Compressor
    var outputs: Seq[(Value, Int)] = in
    for (i <- 0 until compressorLayer.layerNum) {
      outputs = compressorLayer.genLayer(i, outputs)
//      printf(p"lengeh of outs = ${outputs.length}\n")
    }
    outputs
  }

  def apply(down: Vec[Bool], in: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    val compressorLayer = new Compressor
    var outputs: Seq[(Value, Int)] = in
    for (i <- 0 until compressorLayer.layerNum) {
      val pipeLayer = for (k <- compressorLayer.pipeline if k._1 == i) yield k._2
      if (pipeLayer.isEmpty) {
        outputs = compressorLayer.genLayer(i, outputs)
      } else {
        val layerDown: Bool = down(pipeLayer.head)
        val outputsWire = compressorLayer.genLayer(i, outputs)
        var outputsReg: Seq[(Value, Int)] = Seq()
        for (c <- outputsWire) {
          val regC = RegInit(0.U(c._1.value.getWidth.W))
          val v = Wire(new Value(c._1.value.getWidth))
          when (layerDown) {
            regC := c._1.value
          } .otherwise {
            regC := regC
          }
          v.offset = c._1.offset
          v.value := regC
          outputsReg = outputsReg ++ Seq((v, c._2))
        }
        outputs = outputsReg
      }
    }
    outputs
  }
}