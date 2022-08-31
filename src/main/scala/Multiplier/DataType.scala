package Multiplier

import chisel3._
import chisel3.util._

class Value(val w: Int) extends Bundle {
  val value: UInt = Wire(UInt(w.W))
  //  var bitsnum: Int = w
  var offset: Int = new Int
}

object Value {
  def apply(w: Int, value: UInt, offset: Int): Value = {
    val v = new Value(w)
    v.value := value
    v.offset = offset
    v
  }
  def apply(value: UInt, offset: Int): Value = {
    apply(value.getWidth, value, offset)
  }
}



class CompressorOutput(val w: Int) extends Bundle {
  val s: Value = new Value(w)
  val ca: Value = new Value(w)
  def toVec: Vec[Value] = {
    val outVec = VecInit(s, ca)
    outVec
  }
}

