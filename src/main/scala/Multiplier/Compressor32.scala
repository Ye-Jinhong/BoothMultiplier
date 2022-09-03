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
//  printf(p"compressorOutput32.a = ${io.a}\n")
//  printf(p"compressorOutput32.b = ${io.b}\n")
//  printf(p"compressorOutput32.cin = ${io.cin}\n")
  io.s := io.a ^ io.b ^ io.cin
//  printf(p"compressorOutput32.s = ${io.s}\n")
  io.ca := (io.a & io.b) | (io.a & io.cin) | (io.b & io.cin)
//  printf(p"compressorOutput32.ca = ${io.ca}\n")
}

object Compressor32 {
  def apply(in: Seq[Value]): CompressorOutput = {
    require(in.length == 3)
    val offsets: Seq[Int] = for (l <- in) yield l.offset
    val offsetMin: Int = offsets.min
    val width: Seq[Int] = for (w <- in) yield w.value.getWidth
    val length: Seq[Int] = for (l <- offsets.zip(width)) yield l._1 + l._2
    val lengthMax: Int = length.max - offsetMin
//    println(s"length32 = ${length}")
    // Sort p by length
    val inSorted: Seq[(Value, Int)] = in.zip(length).sortBy(p0 => p0._2)
    val compressor32: Compressor32 = Module(new Compressor32(lengthMax))
    if(inSorted(0)._1.offset - offsetMin == 0) compressor32.io.a := inSorted(0)._1.value
    else compressor32.io.a := Cat(inSorted(0)._1.value, Fill(inSorted(0)._1.offset - offsetMin, 0.U(1.W)))
    if(inSorted(1)._1.offset - offsetMin == 0) compressor32.io.b := inSorted(1)._1.value
    else compressor32.io.b := Cat(inSorted(1)._1.value, Fill(inSorted(1)._1.offset - offsetMin, 0.U(1.W)))
    if(inSorted(2)._1.offset - offsetMin == 0) compressor32.io.cin := inSorted(2)._1.value
    else compressor32.io.cin := Cat(inSorted(2)._1.value, Fill(inSorted(2)._1.offset - offsetMin, 0.U(1.W)))

    val compressorOutput: CompressorOutput = Wire(new CompressorOutput(lengthMax))
    compressorOutput.s.value := compressor32.io.s
    compressorOutput.ca.value := compressor32.io.ca
    compressorOutput.s.offset = offsetMin
    compressorOutput.ca.offset = offsetMin + 1
//    printf(p"offset32s = ${compressorOutput.s.offset}\n")
//    printf(p"offset32ca = ${compressorOutput.ca.offset}\n")
    compressorOutput
  }
}
