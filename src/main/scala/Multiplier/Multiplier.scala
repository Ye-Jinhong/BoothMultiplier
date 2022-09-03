package Multiplier

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage


class Multiplier extends Module with BaseData with Topology {
  require(connectCompressor.length == n + 2)
  val io = IO(new Bundle {
//    val pipe1_clk = Input(Clock())
//    val pipe2_clk = Input(Clock())
//    val cpurst_b: Bool = Input(Bool())
//    val pipe1_down = Input(Bool())
//    val pipe2_down = Input(Bool())
    val multiplicand: UInt = Input(UInt(w.W))
    val multiplier: UInt = Input(UInt(w.W))
//    val addend = Input(UInt(w.W))
    val sub_vld: Bool = Input(Bool())
    val product: UInt = Output(UInt((2 * w).W))
  })
  val multiplicand_not: UInt = Wire(UInt(w.W))

  ////for calculate a-b*c, mult calculate can be extend as:
  ////  (~multiplicand + 1) * multiplier
  ////= ~multiplicand * multiplier + multiplier
  when(io.sub_vld) {
    multiplicand_not := ~io.multiplicand
  }.otherwise {
    multiplicand_not := io.multiplicand
  }

  //n partial multiplier
  //  val part_product: Vec[UInt] = Wire(Vec(n, UInt((w + 1).W)))
  val partProductLast: UInt = Wire(UInt((w - 1).W))

  val boothCodeOutput: Vec[BoothCodeOutput] = BoothCode(w, multiplicand_not, io.multiplier)

  //for a-b*c(mult sub),regard multiplier as one part product
  when(io.sub_vld) {
    partProductLast := io.multiplier(w - 2, 0)
  }.otherwise {
    partProductLast := 0.U((w - 1).W)
  }
  // total n + 2 partial products
  val partProducts: Seq[Value] = BCOutput2PProduct.toPProduct(w, boothCodeOutput, partProductLast)
  var inputFromPP: Seq[(Value, Int)] = for (pp <- partProducts.zipWithIndex) yield (pp._1, -pp._2 - 1)

  //  val out2 = Compressor(inputFromPP).filter(x => x._2 == compressorNum)
  val out2: Seq[Value] = for (o <- Compressor(inputFromPP) if o._2 == compressorNum - 1) yield o._1
  printf(p"out2(0) = ${out2(0).value}\n")
  printf(p"out2(1) = ${out2(1).value}\n")
  //----------------------------------------------------------
  //                    L6 compressor
  //----------------------------------------------------------
  // sixth level compressor:
  // components: 1 3:2 compressor
  // result: 3 partial products -> 2 paritial products
  //  val s5_0,c5_0,product_mult_add = Wire( UInt(64.W))
  //  val product_mult = Wire( UInt(130.W))
  //  val x_comp5_0 = Module(new Compressor32(64))
  //  product_mult :=  sum_wire + Cat(carry_wire(128,0),0.U(1.W))
  //  product_mult_add := s5_0(63,0) + Cat(c5_0(62,0),0.U(1.W))
  //  x_comp5_0.io.a := w0(0)
  //  x_comp5_0.io.b := w0(1)
  //  x_comp5_0.io.cin := w0(2)
  //  s5_0 := x_comp5_0.io.s
  //  c5_0 := x_comp5_0.io.ca
  //  io.product := Cat(product_mult(129,64),product_mult_add(63,0))
  if (out2(1).offset == 0 && out2(0).offset == 0)
    io.product := out2(1).value + out2(0).value
  else if (out2(0).offset == 0) {
//    println(s"out2(1).offset == 0")
    io.product := Cat(out2(1).value, Fill(out2(1).offset, 0.U(1.W))) + out2(0).value
  }
  else
    io.product := Cat(out2(1).value, Fill(out2(1).offset, 0.U(1.W))) + Cat(out2(0).value, Fill(out2(0).offset, 0.U(1.W)))

  printf(p"io.multiplier = ${io.multiplier}\n")
  printf(p"io.multiplicand = ${io.multiplicand}\n")
  printf(p"io.product = ${io.product}\n")
}
