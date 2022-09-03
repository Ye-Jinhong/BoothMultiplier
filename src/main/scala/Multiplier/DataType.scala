package Multiplier

import chisel3._
import chisel3.util._

class Value(val w: Int) extends Bundle {
  val value: UInt = UInt(w.W)
  //  var bitsnum: Int = w
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

  //  def copy(other: Value):Value = {
  //    val w = other.value.getWidth
  //    val v = new Value(w)
  //    v.offset = other.offset
  //    v.value := other.value
  //    v
  //  }
}



class CompressorOutput(val w: Int) extends Bundle {
  val s: Value = new Value(w)
  val ca: Value = new Value(w)
  def toSeq: Seq[Value] = {
//    printf(p"ca offset = ${ca.offset}\n")
    val outSeq = Seq(s, ca)
//    printf(p"Vec ca offset = ${outSeq(1).offset}\n")
    outSeq
  }
}

//object CompressorOutput {
//  def apply(w: Int, s: UInt, ca: UInt, offset: Int): CompressorOutput = {
//    val sValue = Wire()
//  }
//}
