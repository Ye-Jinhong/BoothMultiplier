package Multiplier

import chisel3._
import chisel3.util._


object BCOutput2PProduct {
  def toPProduct(w: Int, bcOutput: Vec[BoothCodeOutput], pPLast: UInt): Seq[Value] = {
    val len = bcOutput.length
    val bcOutputIndex = bcOutput.zipWithIndex
    val pProduct: Vec[Value] = Wire(Vec(len - 1, new Value(w + 4)))
    for (i <- 0 until len - 1) {
      if (i == 0) {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product)
        pProduct(i).offset = 0
      }
      else {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product, bcOutputIndex(i - 1)._1.h)
        pProduct(i).offset = bcOutputIndex(i - 1)._2 * 2
      }
    }

    // Additional 3 PP
    val pPLen: Int = if (w % 2 == 0) w + 4 else w + 3
    val valueLen = Wire(new Value(pPLen))
    valueLen.value := Cat(bcOutputIndex(len - 1)._1.sn, bcOutputIndex(len - 1)._1.product, bcOutputIndex(len - 2)._1.h)
    valueLen.offset = (len - 2) * 2

    val valueLenPlus1 = Wire(new Value(w + 1))
    val fill0Num: Int = if (w % 2 == 0) 5 else 4
    valueLenPlus1.value := Cat(Fill(len - 3, "b10".asUInt), 0.U(1.W), Fill(fill0Num, 1.U(1.W)), bcOutputIndex(len - 1)._1.h(0))
    valueLenPlus1.offset = (len - 1) * 2

    val valueLenPlus2 = Wire(new Value(w + 1))
    valueLenPlus2.value := (if(w % 2 == 0) Cat(~pPLast(w - 2), pPLast) else Cat(~pPLast(w - 2), pPLast(w - 2), pPLast))
    valueLenPlus2.offset = 0

    val pProductPlus2: Seq[Value] = ((pProduct :+ valueLen) :+ valueLenPlus1) :+ valueLenPlus2
    pProductPlus2
  }
}