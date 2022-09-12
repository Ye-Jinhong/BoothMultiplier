package Multiplier

import chisel3._
import chisel3.util._

class Compressor42(val w: Int) extends Module {
  val io = IO(new Bundle() {
    val p0: UInt = Input(UInt(w.W))
    val p1: UInt = Input(UInt(w.W))
    val p2: UInt = Input(UInt(w.W))
    val p3: UInt = Input(UInt(w.W))
    val s: UInt = Output(UInt(w.W))
    val ca: UInt = Output(UInt(w.W))
  })
  val xor0: UInt = Wire(UInt(w.W))
  val xor1: UInt = Wire(UInt(w.W))
  val xor2: UInt = Wire(UInt(w.W))
  val cout: UInt= Wire(UInt(w.W))
  val cin: UInt = Wire(UInt(w.W))

  cin := Cat(cout(w - 2, 0), 0.U(1.W))
  xor0 := io.p0 ^ io.p1
  xor1 := io.p2 ^ io.p3
  xor2 := xor1 ^ xor0

  cout := xor0 & io.p2 | ((~xor0).asUInt & io.p0)
  io.s := xor2 ^ cin
  io.ca := xor2 & cin | ((~xor2).asUInt & io.p3)
}

object Compressor42 {
  def apply(p: Seq[Value]): CompressorOutput = {
    require(p.length == 4)
    val offsets: Seq[Int] = for (l <- p) yield l.offset
//    println(s"offsets = ${offsets}")
    val offsetMin: Int = offsets.min
    val width: Seq[Int] = for (w <- p) yield w.value.getWidth
    val length: Seq[Int] = for (l <- offsets.zip(width)) yield l._1 + l._2
    val lengthSorted: Seq[Int] = length.sorted
//    println(s"${lengthSorted}")
    val widthMax: Int = if (lengthSorted(3) > lengthSorted(0) && lengthSorted(3) > lengthSorted(1)) {
      lengthSorted(3) - offsetMin
    } else {
      lengthSorted(3) - offsetMin + 1
    }
//    printf(p"offsetmin = ${offsetMin}\n")
    // Sort p by length
    val pSorted: Seq[(Value, Int)] = p.zip(length).sortBy(p0 => p0._2)
//    println(s"widthMax = ${widthMax}")
    val compressor42: Compressor42 = Module(new Compressor42(widthMax))
    compressor42.io.p0 := pSorted(0)._1.value
    if (pSorted(1)._1.offset-offsetMin == 0) compressor42.io.p1 := pSorted(1)._1.value
    else compressor42.io.p1 := Cat(pSorted(1)._1.value, Fill(pSorted(1)._1.offset-offsetMin, 0.U(1.W)).asUInt)
    if (pSorted(2)._1.offset-offsetMin == 0) compressor42.io.p2 := pSorted(2)._1.value
    else compressor42.io.p2 := Cat(pSorted(2)._1.value, Fill(pSorted(2)._1.offset - offsetMin, 0.U(1.W)))
    if (pSorted(3)._1.offset-offsetMin == 0) compressor42.io.p3 := pSorted(3)._1.value
    else compressor42.io.p3 := Cat(pSorted(3)._1.value, Fill(pSorted(3)._1.offset - offsetMin, 0.U(1.W)))
//    printf(p"p0 = ${compressor42.io.p0}\n")
//    printf(p"p1 = ${compressor42.io.p1}\n")
//    printf(p"offset1 = ${pSorted(1)._1.offset-offsetMin}\n")
//    printf(p"p2 = ${compressor42.io.p2}\n")
//    printf(p"offset2 = ${pSorted(2)._1.offset-offsetMin}\n")
//    printf(p"p3 = ${compressor42.io.p3}\n")
//    printf(p"offset3 = ${pSorted(3)._1.offset-offsetMin}\n")
    val compressorOutput: CompressorOutput = Wire(new CompressorOutput(widthMax))
    compressorOutput.s.value := compressor42.io.s
    compressorOutput.ca.value := compressor42.io.ca
    compressorOutput.s.offset = offsetMin
    compressorOutput.ca.offset = offsetMin + 1
    compressorOutput
  }

  //  def apply(p0: Value, p1: Value, p2: Value, p3: Value): CompressorOutput = {
  //    val p = VecInit(p0, p1, p2, p3)
  //    apply(p)
  //  }
  //
  //  def apply(p: Seq[Value]): CompressorOutput = {
  //    require(p.length == 4)
  //    apply(p(0), p(1), p(2), p(3))
  //  }
}