package Multiplier

import chisel3._
import chisel3.util._


class Multiplier extends Module with BaseData with Topology {
  require(connectCompressor.length == n + 2)
  val io = IO(new Bundle {
    val down: Vec[Bool] = if (isPipeline) Input(Vec(pipeline.length, Bool())) else null
    val multiplicand: SInt = Input(SInt(w.W))
    val multiplier: SInt = Input(SInt(w.W))
    val addend: SInt = Input(SInt(w.W))
    val sub_vld: Bool = Input(Bool())
    val product: SInt = Output(SInt((2 * w).W))
  })
  val multiplicand_not: UInt = Wire(UInt(w.W))

  //for calculate a-b*c, mult calculate can be extend as:
  //  (~multiplicand + 1) * multiplier
  //= ~multiplicand * multiplier + multiplier
  when(io.sub_vld) {
    multiplicand_not := (~io.multiplicand).asUInt
  }.otherwise {
    multiplicand_not := io.multiplicand.asUInt
  }

  //n partial multiplier
  //  val part_product: Vec[UInt] = Wire(Vec(n, UInt((w + 1).W)))
  val partProductLast: UInt = Wire(UInt((w - 1).W))

  val boothCodeOutput: Vec[BoothCodeOutput] = BoothCode(w, multiplicand_not, io.multiplier.asUInt)

  //for a-b*c(mult sub),regard multiplier as one part product
  when(io.sub_vld) {
    partProductLast := io.multiplier(w - 2, 0).asUInt
  }.otherwise {
    partProductLast := 0.U((w - 1).W)
  }
  // total n + 2 partial products
  val partProducts: Seq[Value] = BCOutput2PProduct.toPProduct(w, boothCodeOutput, partProductLast)
  var inputFromPP: Seq[(Value, Int)] = for (pp <- partProducts.zipWithIndex) yield (pp._1, -pp._2 - 1)


  val compressorOutLast: Seq[Value] =
    if (!isPipeline)
      for (o <- Compressor(inputFromPP)) yield o._1
    else
      for (o <- Compressor(io.down, inputFromPP)) yield o._1
  require(compressorOutLast.length == 2)
  require(compressorOutLast(1).offset == 1 && compressorOutLast(0).offset == 0)

  val sum: UInt = Wire(UInt((2 * w).W))
  val carry: UInt = Wire(UInt((2 * w).W))
  val addend: SInt = Wire(SInt((w - 1).W))
  sum := compressorOutLast(0).value
  carry := compressorOutLast(1).value
  addend := io.addend
  val compressor32Out: CompressorOutput =
    if (isLastLayerPipe) AddAddend(w, io.down.last, sum, carry, addend)
    else AddAddend(w, sum, carry, addend)
//  val compressor32Out: CompressorOutput = AddAddend(w, sum, carry, io.addend)
  val productMult: UInt = Wire(UInt((2 * w).W))
  val productMultAdd: UInt = Wire(UInt((w - 1).W))
  productMult := (carry << 1).asUInt + sum
  productMultAdd := (compressor32Out.ca.value << 1).asUInt + compressor32Out.s.value



  io.product := Cat(productMult(2*w-1,w-1),productMultAdd(w-2,0)).asSInt

  printf(p"io.product = ${io.product}\n")
}
