package Multiplier

import chisel3._
import chisel3.util._


class Compressor32(val w : Int) extends Module {
  val io = IO(new Bundle() {
    val cin: UInt = Input(UInt(w.W))
    val a: UInt = Input(UInt(w.W))
    val b: UInt = Input(UInt(w.W))
    val s: UInt = Output(UInt(w.W))
    val ca: UInt = Output(UInt(w.W))
  })

  io.s := io.a ^ io.b ^ io.cin
  io.ca := io.a & io.b | io.a & io.cin | io.b & io.cin
}

object Compressor32 {
  def apply(in: Vec[Value]): CompressorOutput = {
    require(in.length == 3)
    val offsets: Seq[Int] = for (l <- in) yield l.offset
    val offsetMin: Int = offsets.min
    val width: Seq[Int] = for (w <- in) yield w.value.getWidth
    val length: Seq[Int] = for (l <- offsets.zip(width)) yield l._1 + l._2
    val lengthMax: Int = length.max - offsetMin

    val compressor32: Compressor32 = Module(new Compressor32(lengthMax))

    compressor32.io.a := Cat(in(0).value, Fill(in(0).offset - offsetMin, 0.U(1.W)))
    compressor32.io.b := Cat(in(1).value, Fill(in(1).offset - offsetMin, 0.U(1.W)))
    compressor32.io.cin := Cat(in(2).value, Fill(in(2).offset - offsetMin, 0.U(1.W)))
    val compressorOutput: CompressorOutput = new CompressorOutput(lengthMax)
    compressorOutput.s.value := compressor32.io.s
    compressorOutput.ca.value := compressor32.io.ca
    compressorOutput.s.offset = offsetMin
    compressorOutput.ca.offset = offsetMin + 1
    compressorOutput
  }
  def apply(in1: Value, in2: Value, in3: Value): CompressorOutput = {
    val in = VecInit(in1, in2, in3)
    apply(in)
  }
}
