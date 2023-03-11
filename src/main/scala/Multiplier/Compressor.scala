package Multiplier

import chisel3._
import chisel3.util._


class Compressor extends Topology {
  val layerNum: Int = layer.length

  // Generate the compressor in layer l
  def genLayer(l: Int, input: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    // l -> layer index
    // topology -> ((from where, connect type), to where)
    // input -> (value, from where)
    // return -> (value, from where)
    val compressorIndex: Seq[Int] = layer(l)
    // Find all the connections that output is in layer l
    val t: Seq[((Int, Int), Int)] = topologyAll.filter(t => compressorIndex.contains(t._2))
    // Call genCompressor(...)
    genCompressor(compressorIndex.head, compressorIndex.last, input, t)
  }

  // Generate the compressor from a to b
  def genCompressor(a: Int, b: Int, input: Seq[(Value, Int)], topology: Seq[((Int, Int), Int)]): Seq[(Value, Int)] = {
    // a, b -> compressor index
    // input -> (value, from where)
    // topology -> ((from where, connect type), to where)
    // return -> (value, from where)
    require(a <= b)
    if (a == b) {
      // Instantiate Compressor a
      // t0 -> ((from where, connect type), to where)
      // Find all the connections that output is Compressor a
      val t0 = for (c <- topology if c._2 == a) yield c
      val inputIndex: Seq[((Value, Int), Int)] = input.zipWithIndex

      // Index where inputs from
      val in1 = for (i <- t0 if i._1._2 == 1) yield i._1._1
      val in2 = for (i <- t0 if i._1._2 == 2) yield i._1._1
      val in3 = for (i <- t0 if i._1._2 == 3) yield i._1._1

      var in: Seq[Value] = Seq()
      var inIndex: Seq[Int] = Seq()
      // The inputs that do not be used
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
      // Instantiate Compressor
      val outs = Compressor(in)
      // Output all the values that remained
      inRemains = for(i <- inputIndex if !inIndex.contains(i._2)) yield i._1
      (for (i <- outs.toSeq) yield (i, a)) ++ inRemains
    } else {
      val inRemains = genCompressor(b, b, input, topology)
      genCompressor(a, b - 1, inRemains, topology)
    }
  }
}


object Compressor {
  def apply(in: Seq[Value]): CompressorOutput = {
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

  // Pipeline
  def apply(down: Vec[Bool], in: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    // down -> pipeline valid signal
    // in -> (value, from where)
    // return -> (value, from where)
    val compressorLayer = new Compressor
    var outputs: Seq[(Value, Int)] = in
    for (i <- 0 until compressorLayer.layerNum) {
      val pipeLayer = for (k <- compressorLayer.pipeline if k._1 == i) yield k._2
      if (pipeLayer.isEmpty) {
        // This layer is no pipeline
        outputs = compressorLayer.genLayer(i, outputs)
      } else {
        // This layer is pipeline
        val layerDown: Bool = down(pipeLayer.head)
        // Outputs that to pass registers
        val outputsWire = compressorLayer.genLayer(i, outputs)
        // Outputs that have passed registers
        var outputsReg: Seq[(Value, Int)] = Seq()
        // For every outputs
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

  def apply(clk2: Clock, down: Vec[Bool], in: Seq[(Value, Int)]): Seq[(Value, Int)] = {
    // clk2 -> additional clock signal
    // down -> pipeline valid signal
    // in -> (value, from where)
    // return -> (value, from where)
    require(down.length == 2)
    val compressorLayer = new Compressor
    var outputs: Seq[(Value, Int)] = in

    val firstLayerToPipe = compressorLayer.pipeline.head._1
    val secondLayerToPipe = compressorLayer.pipeline.last._1
    for (i <- 0 until compressorLayer.layerNum) {
      val pipeLayer = for (k <- compressorLayer.pipeline if k._1 == i) yield k._2
      if (pipeLayer.isEmpty) {
        // This layer is no pipeline
        outputs = compressorLayer.genLayer(i, outputs)
      } else {
        // Additional clock
        val useClock2: Boolean = pipeLayer.head == 0
        // This layer is pipeline
        val layerDown: Bool = down(pipeLayer.head)
        // Outputs that to pass registers
        val outputsWire = compressorLayer.genLayer(i, outputs)
        // Outputs that have passed registers
        var outputsReg: Seq[(Value, Int)] = Seq()
        // For every outputs
        if (!useClock2) {
          for (c <- outputsWire) {
            val regC = RegInit(0.U(c._1.value.getWidth.W))
            val v = Wire(new Value(c._1.value.getWidth))
            when(layerDown) {
              regC := c._1.value
            }.otherwise {
              regC := regC
            }
            v.offset = c._1.offset
            v.value := regC
            outputsReg = outputsReg ++ Seq((v, c._2))
          }
        } else {
          withClock(clk2) {
            for (c <- outputsWire) {
              val regC = RegInit(0.U(c._1.value.getWidth.W))
              val v = Wire(new Value(c._1.value.getWidth))
              when(layerDown) {
                regC := c._1.value
              }.otherwise {
                regC := regC
              }
              v.offset = c._1.offset
              v.value := regC
              outputsReg = outputsReg ++ Seq((v, c._2))
            }
          }
        }
        outputs = outputsReg
      }
    }
    outputs
  }

}