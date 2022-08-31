package Multiplier

import chisel3._
import chisel3.util._

class CompressorOutput(val w: Int) extends Bundle {
  val s: UInt = UInt(w.W)
  val ca: UInt = UInt(w.W)
}

class Compressor42Unit(val w: Int) extends Module {
  val io = IO(new Bundle() {
    val p0 = Input(UInt(w.W))
    val p1 = Input(UInt(w.W))
    val p2 = Input(UInt(w.W))
    val p3 = Input(UInt(w.W))
    val cin = Input(UInt(w.W))
    val s = Output(UInt(w.W))
    val ca = Output(UInt(w.W))
    val cout = Output(UInt(w.W))
  })
  val xor0 = Wire(UInt(w.W))
  val xor1 = Wire(UInt(w.W))
  val xor2 = Wire(UInt(w.W))

  xor0 := io.p0 ^ io.p1
  xor1 := io.p2 ^ io.p3
  xor2 := xor1 ^ xor0

  io.cout := xor0 & io.p2 | ((~xor0).asUInt & io.p0)
  io.s := xor2 ^ io.cin
  io.ca := xor2 & io.cin | ((~xor2).asUInt & io.p3)
}
class Compressor42(val w: Int) extends Module {
  val io = IO(new Bundle() {
    val p0: UInt = Input(UInt(w.W))
    val p1: UInt = Input(UInt(w.W))
    val p2: UInt = Input(UInt(w.W))
    val p3: UInt = Input(UInt(w.W))
    val compressorOutput: CompressorOutput = Output(new CompressorOutput(w))
  })
  val compressor42Unit: Compressor42Unit = Module(new Compressor42Unit(w))
  compressor42Unit.io.p0 := io.p0
  compressor42Unit.io.p1 := io.p1
  compressor42Unit.io.p2 := io.p2
  compressor42Unit.io.p3 := io.p3
  compressor42Unit.io.cin := Cat(compressor42Unit.io.cout(w-2,0), 0.U(1.W))
  io.compressorOutput.s := compressor42Unit.io.s
  io.compressorOutput.ca := compressor42Unit.io.ca
}

object Compressor42{
  def apply(w: Int, )
}