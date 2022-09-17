package Multiplier

import chisel3._
import chisel3.util._

class BoothCodeOutput(val w: Int) extends Bundle {
  val product : UInt= UInt((w+1).W)
  val h : UInt = UInt(2.W)
  val sn : UInt = UInt(1.W)
}

object BoothCodeOutput {
  def apply(w: Int): BoothCodeOutput = new BoothCodeOutput(w)
}

class BoothCodeUnit(val w: Int) extends Module {
  val io = IO(new Bundle {
    val A : UInt= Input(UInt(w.W))
    val code : UInt = Input(UInt(3.W))
    val boothCodeOutput: BoothCodeOutput = Output(new BoothCodeOutput(w))
  })
  val A_sign : UInt = Wire(UInt(1.W))
  A_sign := io.A(w-1)

  when(io.code === "b000".U) {
    io.boothCodeOutput.product := 0.U((w+1).W)
    io.boothCodeOutput.sn := "b1".U
    io.boothCodeOutput.h := "b00".U
  }.elsewhen(io.code === "b001".U) {
    io.boothCodeOutput.product := Cat(A_sign, io.A)
    io.boothCodeOutput.sn := ~A_sign
    io.boothCodeOutput.h := "b00".U
  }.elsewhen(io.code === "b010".U) {
    io.boothCodeOutput.product := Cat(A_sign, io.A)
    io.boothCodeOutput.sn := ~A_sign
    io.boothCodeOutput.h := "b00".U
  }.elsewhen(io.code === "b011".U) {
    io.boothCodeOutput.product := Cat(io.A, "b0".U)
    io.boothCodeOutput.sn := ~A_sign
    io.boothCodeOutput.h := "b00".U
  }.elsewhen(io.code === "b100".U) {
    io.boothCodeOutput.product := Cat(~io.A, "b1".U)
    io.boothCodeOutput.sn := A_sign
    io.boothCodeOutput.h := "b01".U
  }.elsewhen(io.code === "b101".U) {
    io.boothCodeOutput.product := Cat(~A_sign, ~io.A)
    io.boothCodeOutput.sn := A_sign
    io.boothCodeOutput.h := "b01".U
  }.elsewhen(io.code === "b110".U) {
    io.boothCodeOutput.product := Cat(~A_sign, ~io.A)
    io.boothCodeOutput.sn := A_sign
    io.boothCodeOutput.h := "b01".U
  }.elsewhen(io.code === "b111".U) {
    io.boothCodeOutput.product := 0.U((w+1).W)
    io.boothCodeOutput.sn := "b1".U
    io.boothCodeOutput.h := "b00".U
  }.otherwise{
    io.boothCodeOutput.product := 0.U((w+1).W)
    io.boothCodeOutput.sn := "b1".U
    io.boothCodeOutput.h := "b00".U
  }
}

object BoothCodeUnit{
  def apply(w: Int, A: UInt, code: UInt): BoothCodeOutput = {
    val boothCodeUnit = Module(new BoothCodeUnit(w))
    boothCodeUnit.io.A := A
    boothCodeUnit.io.code := code
    boothCodeUnit.io.boothCodeOutput
  }
  def apply(A: UInt, code: UInt): BoothCodeOutput = {
    val w = A.getWidth
    apply(w, A, code)
  }
}


object BoothCode{
  def apply(w: Int, A: UInt, code: UInt): Vec[BoothCodeOutput] = {
    val codewidth = code.getWidth
    if(codewidth == 2){
      VecInit(BoothCodeUnit(w, A, Cat(code, 0.U(1.W))))
    }else if(codewidth % 2 == 0){
      VecInit(apply(w, A, code(codewidth - 3, 0)) :+ BoothCodeUnit(w, A, code(codewidth - 1, codewidth - 3)))
    }else{
      VecInit(apply(w, A, code(codewidth - 2, 0)) :+ BoothCodeUnit(w, A, Cat(code(codewidth - 1), code(codewidth - 1, codewidth - 2))))
    }
  }
  def apply(A: UInt, code: UInt): Vec[BoothCodeOutput] = {
    apply(A.getWidth, A, code)
  }
}



