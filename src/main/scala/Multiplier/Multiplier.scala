package Multiplier

import chisel3._
import chisel3.util._


class Multiplier extends Module with Topology {
  val io = IO(new Bundle {
    val clock2 = if (multiClock && !debugFlag) Input(Clock()) else null
    val down: Vec[Bool] = if (isPipeline) Input(Vec(pipeline.length, Bool())) else null
    val multiplicand: SInt = Input(SInt(w.W))
    val multiplier: SInt = Input(SInt(w.W))
    val addend: SInt = Input(SInt(w.W))
    val sub_vld: Bool = Input(Bool())
    val product: SInt = Output(SInt((2 * w).W))
  })
  // Debug clock
  val clock_div = if (debugFlag) RegInit(true.B) else null
  if (debugFlag) clock_div := ~clock_div
  val clock2 = if (debugFlag) clock_div.asClock else null

  val multiplicand_not: UInt = Wire(UInt(w.W))

  // When calculate a-b*c, mult calculate can be extend as:
  //  (~multiplicand + 1) * multiplier
  //  = ~multiplicand * multiplier + multiplier
  when(io.sub_vld) {
    multiplicand_not := (~io.multiplicand).asUInt
  }.otherwise {
    multiplicand_not := io.multiplicand.asUInt
  }

  // Generate booth code output
  val boothCodeOutput: Vec[BoothCodeOutput] = BoothCode(w, multiplicand_not, io.multiplier.asUInt)

  // the last partial multiplier
  // For a-b*c (mult sub), regard multiplier as one part product
  val partProductLast: UInt = Wire(UInt(w.W))
  when(io.sub_vld) {
    partProductLast := io.multiplier.asUInt
  }.otherwise {
    partProductLast := 0.U(w.W)
  }

  // total n + 2 partial products
  val partProducts: Seq[Value] = BCOutput2PProduct.toPProduct(w, boothCodeOutput, partProductLast)
  // Input to Compressor tree
  var inputFromPP: Seq[(Value, Int)] = for (pp <- partProducts.zipWithIndex) yield (pp._1, pp._2 - ppNum)

  val compressorOutLast: Seq[Value] =
    if (!isPipeline)
      for (o <- Compressor(inputFromPP)) yield o._1
    else if (!multiClock)
      for (o <- Compressor(io.down, inputFromPP)) yield o._1
    else {
      if (debugFlag) {
        for (o <- Compressor(clock2, io.down, inputFromPP)) yield o._1
      } else
        for (o <- Compressor(io.clock2, io.down, inputFromPP)) yield o._1
    }
  // There should be two value in outputs (s, ca)
  require(compressorOutLast.length == 2)
  require(compressorOutLast(1).offset == 1 && compressorOutLast(0).offset == 0)

  // Add the addend
  val sum: UInt = Wire(UInt((2 * w).W))
  val carry: UInt = Wire(UInt((2 * w).W))
  val addend: SInt = Wire(SInt((w - 1).W))
  sum := compressorOutLast(0).value
  carry := compressorOutLast(1).value
  addend := io.addend

  val compressor32Out: CompressorOutput =
    if (!multiClock)
      AddAddend(w, io.down.last, sum, carry, addend)
    else {
      if (debugFlag)
        AddAddend(w, clock2, io.down.last, sum, carry, addend)
      else
        AddAddend(w, io.clock2, io.down.last, sum, carry, addend)
    }

  // Generate the mult and mult-add output
  val productMult: UInt = Wire(UInt((2 * w).W))
  val productMultAdd: UInt = Wire(UInt((w - 1).W))
  productMult := (carry << 1).asUInt + sum
  productMultAdd := (compressor32Out.ca.value << 1).asUInt + compressor32Out.s.value

  io.product := Cat(productMult(2*w-1,w-1),productMultAdd(w-2,0)).asSInt

//  printf(p"io.product = ${io.product}\n")
}

object Multiplier {
  def apply(): Multiplier = new Multiplier()
//  def apply(w: Int): Multiplier = {
//    val m = new Multiplier()
//    m.w = w
//    m
//  }
}