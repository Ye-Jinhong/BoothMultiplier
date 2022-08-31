package Multiplier

import chisel3._
import chisel3.util._


object BCOutput2PProduct {
  def toPProduct(w: Int, bcOutput: Vec[BoothCodeOutput], pPLast: UInt): Vec[Value] = {
    val len = bcOutput.length
    val bcOutputIndex = bcOutput.zipWithIndex
    val pProduct: Vec[Value] = Vec(len+2, new Value(w+4))
    for(i <- 0 until len + 2) {
      if(i == 0) {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, !bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product)
        pProduct(i).offset = 0
      }else if(i == len+1) {
        pProduct(i).value := pPLast
        pProduct(i).offset = 0
      }else if(i == len) {
        val fill0Num: Int = if (w % 2 == 0) 3 else 2
        pProduct(i).value := Cat(Fill(len-2, "b10".asUInt), Fill(fill0Num, 0.U(1.W)), bcOutputIndex(i-1)._1.h)
        pProduct(i).offset = bcOutputIndex(i)._2 * 2
      }
      else {
        pProduct(i).value := Cat(bcOutputIndex(i)._1.sn, bcOutputIndex(i)._1.product, bcOutputIndex(i-1)._1.h)
        pProduct(i).offset = bcOutputIndex(i)._2 * 2
      }
    }
    pProduct
  }
}