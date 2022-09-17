package Multiplier

import chisel3._

class Value(val w: Int) extends Bundle {
  val value: UInt = UInt(w.W)
  var offset: Int = 0
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
  def toSeq: Seq[Value] = {
    val outSeq = Seq(s, ca)
    outSeq
  }
}

