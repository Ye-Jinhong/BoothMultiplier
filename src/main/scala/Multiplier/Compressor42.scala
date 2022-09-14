package Multiplier

import chisel3._
import chisel3.util._

class Compressor42(val w: Int) extends Module {
  val io = IO(new Bundle() {
    val p: Vec[UInt] = Input(Vec(4, UInt(w.W)))
    val s: UInt = Output(UInt(w.W))
    val ca: UInt = Output(UInt(w.W))
  })
  val xor0: UInt = Wire(UInt(w.W))
  val xor1: UInt = Wire(UInt(w.W))
  val xor2: UInt = Wire(UInt(w.W))
  val cout: UInt= Wire(UInt(w.W))
  val cin: UInt = Wire(UInt(w.W))

  cin := Cat(cout(w - 2, 0), 0.U(1.W))
  xor0 := io.p(0) ^ io.p(1)
  xor1 := io.p(2) ^ io.p(3)
  xor2 := xor1 ^ xor0

  cout := xor0 & io.p(2) | ((~xor0).asUInt & io.p(0))
  io.s := xor2 ^ cin
  io.ca := xor2 & cin | ((~xor2).asUInt & io.p(3))
}

object Compressor42 {
  def apply(p: Seq[Value]): CompressorOutput = {
    require(p.length == 4)
    // Calculate the minimum offset
    val offsets: Seq[Int] = for (l <- p) yield l.offset
    val offsetMin: Int = offsets.min
    // Get the used width of every value
    val width: Seq[Int] = for (w <- p) yield w.value.getWidth
    // Calculate the actual length of every value
    val length: Seq[Int] = for (l <- offsets.zip(width)) yield l._1 + l._2
    // Calculate the width need to be used
    val lengthSorted: Seq[Int] = length.sorted
    val widthMax: Int = if (lengthSorted(3) > lengthSorted(0) && lengthSorted(3) > lengthSorted(1)) {
      lengthSorted(3) - offsetMin
    } else {
      lengthSorted(3) - offsetMin + 1
    }
    // Sort p by its actual length
    val pSorted: Seq[Value] = p.zip(length).sortBy(p0 => p0._2).map(x => x._1)
    // Zeros to be fill
    val zeroFill: Seq[Int] = pSorted.map(x => x.offset - offsetMin)
    // Instantiate Compressor42
    val compressor42: Compressor42 = Module(new Compressor42(widthMax))

    for( i <- 0 until 4) {
      if (zeroFill(i) == 0) compressor42.io.p(i) := pSorted(i).value
      else compressor42.io.p(i) := Cat(pSorted(i).value, Fill(zeroFill(i), 0.U(1.W)))
    }

    val compressorOutput: CompressorOutput = Wire(new CompressorOutput(widthMax))
    compressorOutput.s.value := compressor42.io.s
    compressorOutput.ca.value := compressor42.io.ca
    compressorOutput.s.offset = offsetMin
    compressorOutput.ca.offset = offsetMin + 1
    compressorOutput
  }

}