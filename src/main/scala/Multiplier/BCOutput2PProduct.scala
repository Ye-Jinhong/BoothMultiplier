package Multiplier

import chisel3._
import chisel3.util._


object BCOutput2PProduct {
  def toPProduct(w: Int, bcOutput: Vec[BoothCodeOutput], pPLast: UInt): Seq[Value] = {
    val len = bcOutput.length
    val bcOutputIndex = bcOutput.zipWithIndex
    val pProduct: Vec[Value] = Wire(Vec(len, new Value(w + 4)))
    for (i <- 0 until len) {
      if (i == 0) {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product)
        pProduct(i).offset = 0
//        printf(p"value(${i}) = ${pProduct(i).value}\n")
      }
      else {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product, bcOutputIndex(i - 1)._1.h)
        pProduct(i).offset = bcOutputIndex(i - 1)._2 * 2
//        printf(p"value(${i}) = ${pProduct(i).value}\n")
//        println(s"offset(${i}) = ${pProduct(i).offset}\n")
      }
    }
    val valueLenPlus1 = Wire(new Value(w + 1))
    val fill0Num: Int = if (w % 2 == 0) 3 else 2
    valueLenPlus1.offset = (len - 1) * 2
    valueLenPlus1.value := Cat(Fill(len - 2, "b10".asUInt), Fill(fill0Num, 0.U(1.W)), bcOutputIndex(len - 1)._1.h)
//    printf(p"value = ${valueLenPlus1.value}\n")
//    println(s"offset = ${valueLenPlus1.offset}\n")

    val valueLenPlus2 = Wire(new Value(w - 1))
    valueLenPlus2.value := pPLast
    valueLenPlus2.offset = 0
//    printf(p"value2 = ${valueLenPlus2.value}\n")

    //    val pProductPlus2: Vec[Value] = VecInit(VecInit(pProduct :+ valueLenPlus1) :+ valueLenPlus2)

    val pProductPlus2: Seq[Value] = (pProduct.toSeq :+ valueLenPlus1) :+ valueLenPlus2
    pProductPlus2
  }
}