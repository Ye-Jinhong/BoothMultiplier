package Multiplier

import chisel3._

object AddAddend {
  def apply(w: Int, sum: UInt, carry: UInt, addend: SInt): CompressorOutput = {
    val compressor32In: Vec[Value] = Wire(Vec(3, new Value(w - 1)))
    compressor32In(0).value := sum(w - 2, 0)
    compressor32In(0).offset = 0
    compressor32In(1).value := carry(w - 2, 0)
    compressor32In(1).offset = 1
    compressor32In(2).value := addend.asUInt
    compressor32In(2).offset = 0
    Compressor32(compressor32In)
  }
}