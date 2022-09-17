package Multiplier

import chisel3._
import chisel3.util._


class Compressor32(val w : Int) extends Module {
  val io = IO(new Bundle() {
    val in: Vec[UInt] = Input(Vec(3, UInt(w.W)))
    val s: UInt = Output(UInt(w.W))
    val ca: UInt = Output(UInt(w.W))
  })
  val a: UInt = Wire(UInt(w.W))
  val b: UInt = Wire(UInt(w.W))
  val cin: UInt = Wire(UInt(w.W))

  a := io.in(0)
  b := io.in(1)
  cin := io.in(2)

  io.s := a ^ b ^ cin
  io.ca := (a & b) | (a & cin) | (b & cin)
}

object Compressor32 {
  def apply(in: Seq[Value]): CompressorOutput = {
    require(in.length == 3)
    // Calculate the minimum offset
    val offsets: Seq[Int] = for (l <- in) yield l.offset
    val offsetMin: Int = offsets.min
    // Get the used width of every value
    val width: Seq[Int] = for (w <- in) yield w.value.getWidth
    // Calculate the actual length of every value
    val length: Seq[Int] = for (l <- offsets.zip(width)) yield l._1 + l._2
    // Calculate the width need to be used
    val lengthMax: Int = length.max - offsetMin
    // Sort in by its actual length
    val inSorted: Seq[Value] = in.zip(length).sortBy(x => x._2).map(x => x._1)
    // Zeros to be filled
    val zeroFill: Seq[Int] = inSorted.map(x => x.offset - offsetMin)
    // Instantiate Compressor32
    val compressor32: Compressor32 = Module(new Compressor32(lengthMax))

    for( i <- 0 until 3) {
      if (zeroFill(i) == 0) compressor32.io.in(i) := inSorted(i).value
      else compressor32.io.in(i) := Cat(inSorted(i).value, Fill(zeroFill(i), 0.U(1.W)))
    }

    val compressorOutput: CompressorOutput = Wire(new CompressorOutput(lengthMax))
    compressorOutput.s.value := compressor32.io.s
    compressorOutput.ca.value := compressor32.io.ca
    compressorOutput.s.offset = offsetMin
    compressorOutput.ca.offset = offsetMin + 1
    compressorOutput
  }
}
