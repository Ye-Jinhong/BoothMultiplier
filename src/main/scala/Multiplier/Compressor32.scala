package Multiplier

import chisel3._

class Compressor32(val w : Int) extends Module {
  val io = IO(new Bundle() {
    val cin = Input(UInt(w.W))
    val a = Input(UInt(w.W))
    val b = Input(UInt(w.W))
    val s = Output(UInt(w.W))
    val ca = Output(UInt(w.W))
  })

  io.s := io.a ^ io.b ^ io.cin
  io.ca := io.a & io.b | io.a & io.cin | io.b & io.cin
}
