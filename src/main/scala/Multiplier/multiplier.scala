package Multiplier

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage


class multiplier extends Module with Topology {
  val io = IO(new Bundle {
    val pipe1_clk = Input(Clock())
    val pipe2_clk = Input(Clock())
    val cpurst_b = Input(Bool())
    val pipe1_down = Input(Bool())
    val pipe2_down = Input(Bool())
    val multiplicand = Input(UInt(w.W))
    val multiplier = Input(UInt(w.W))
    val addend = Input(UInt(w.W))
    val sub_vld = Input(Bool())
    val product = Output(UInt((2*w).W))
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
  val part_product_last: UInt = Wire(UInt(w.W))
//  val h: Vec[UInt] = Wire(Vec(n, UInt(2.W)))
//  val sign_not: Vec[UInt] = Wire(Vec(n, UInt(1.W)))
//  val x_booth_code = Seq.fill(33)(Module(new booth_code(65)))

  val boothCodeOutput: Vec[BoothCodeOutput] = Wire(BoothCode(w, multiplicand_not, io.multiplier))

  //for a-b*c(mult sub),regard multiplier as one part product
  when(io.sub_vld) {
    part_product_last := Cat(0.U(2.W), io.multiplier(63, 0))
  }.otherwise {
    part_product_last := 0.U(66.W)
  }

  //----------------------------------------------------------
  //                    L1 compressor
  //----------------------------------------------------------
  // first level compressor:
  // components: 8 4:2 compressor
  // result: 34 partial products -> 18 paritial products
  val p0, p1, p2, p3, p_cin, cout0 = Wire(Vec(8, UInt(75.W)))
  for (i <- 0 to 7) {
    if (i == 0) {
      p0(i) := Seq(0.U(6.W), sign_not(i), Fill(2, !sign_not(i)), part_product(i)).reduce(Cat(_, _))
      p1(i) := Seq(0.U(6.W), sign_not(i * 4 + 1), part_product(i * 4 + 1), h(i * 4)).reduce(Cat(_, _))
      p2(i) := Seq(0.U(4.W), sign_not(i * 4 + 2), part_product(i * 4 + 2), h(i * 4 + 1), 0.U(2.W)).reduce(Cat(_, _))
      p3(i) := Seq(0.U(2.W), sign_not(i * 4 + 3), part_product(i * 4 + 3), h(i * 4 + 2), 0.U(4.W)).reduce(Cat(_, _))
      p_cin(i) := Seq(0.U(2.W), cout0(i)(71, 0), 0.U(1.W)).reduce(Cat(_, _))
    }
    else {
      p0(i) := Seq(0.U(6.W), sign_not(i * 4), part_product(i * 4), h(4 * i - 1)).reduce(Cat(_, _))
      p1(i) := Seq(0.U(4.W), sign_not(i * 4 + 1), part_product(i * 4 + 1), h(i * 4), 0.U(2.W)).reduce(Cat(_, _))
      p2(i) := Seq(0.U(2.W), sign_not(i * 4 + 2), part_product(i * 4 + 2), h(i * 4 + 1), 0.U(4.W)).reduce(Cat(_, _))
      p3(i) := Seq(sign_not(i * 4 + 3), part_product(i * 4 + 3), h(i * 4 + 2), 0.U(6.W)).reduce(Cat(_, _))
      p_cin(i) := Seq(cout0(i)(73, 0), 0.U(1.W)).reduce(Cat(_, _))
    }
  }
  val s0, c0 = Wire(Vec(8, UInt(75.W)))
  val x_comp_1 = Seq.fill(8)(Module(new Compressor42(75)))
  for (i: Int <- 0 to 7) {
    x_comp_1(i).io.p0 := p0(i)
    x_comp_1(i).io.p1 := p1(i)
    x_comp_1(i).io.p2 := p2(i)
    x_comp_1(i).io.p3 := p3(i)
    s0(i) := x_comp_1(i).io.s
    c0(i) := x_comp_1(i).io.ca
    cout0(i) := x_comp_1(i).io.cout
  }
  //----------------------------------------------------------
  //                    L2 compressor
  //----------------------------------------------------------
  // second level compressor:
  // components: 6 3:2 compressor
  // result: 18 partial products -> 12 paritial products
  val q0, q1, q2 = Wire(Vec(6, UInt(83.W)))

  q0(0) := Seq(0.U(10.W), s0(0)(72, 0)).reduce(Cat(_, _))
  q1(0) := Seq(0.U(9.W), c0(0)(72, 0), 0.U(1.W)).reduce(Cat(_, _))
  q2(0) := Seq(0.U(2.W), s0(1)(74, 0), 0.U(6.W)).reduce(Cat(_, _))


  q0(1) := Seq(0.U(8.W), c0(1)(74, 0)).reduce(Cat(_, _))
  q1(1) := Seq(0.U(1.W), s0(2)(74, 0), 0.U(7.W)).reduce(Cat(_, _))
  q2(1) := Seq(c0(2)(74, 0), 0.U(8.W)).reduce(Cat(_, _))

  q0(2) := Seq(0.U(8.W), s0(3)(74, 0)).reduce(Cat(_, _))
  q1(2) := Seq(0.U(7.W), c0(3)(74, 0), 0.U(1.W)).reduce(Cat(_, _))
  q2(2) := Seq(s0(4)(74, 0), 0.U(8.W)).reduce(Cat(_, _))

  q0(3) := Seq(0.U(8.W), c0(4)(74, 0)).reduce(Cat(_, _))
  q1(3) := Seq(0.U(1.W), s0(5)(74, 0), 0.U(7.W)).reduce(Cat(_, _))
  q2(3) := Seq(c0(5)(74, 0), 0.U(8.W)).reduce(Cat(_, _))

  q0(4) := Seq(0.U(8.W), s0(6)(74, 0)).reduce(Cat(_, _))
  q1(4) := Seq(0.U(7.W), c0(6)(74, 0), 0.U(1.W)).reduce(Cat(_, _))
  q2(4) := Seq(s0(7)(74, 0), 0.U(8.W)).reduce(Cat(_, _))

  q0(5) := Seq(0.U(8.W), c0(7)(74, 0)).reduce(Cat(_, _))
  q1(5) := Seq(0.U(8.W), part_product(32)(65, 0), h(31), 0.U(7.W)).reduce(Cat(_, _))
  q2(5) := Seq(0.U(8.W), Fill(31, 2.U),0.U(2.W),  h(32), part_product(33)(63, 55)).reduce(Cat(_, _))

  val s1, c1 = Wire(Vec(6, UInt(83.W)))
  val x_comp_2: Seq[Compressor32] = Seq.fill(6)(Module(new Compressor32(83)))
  for (i: Int <- 0 to 5) {
    x_comp_2(i).io.a := q0(i)
    x_comp_2(i).io.b := q1(i)
    x_comp_2(i).io.cin := q2(i)
    s1(i) := x_comp_2(i).io.s
    c1(i) := x_comp_2(i).io.ca
  }
  val s_reg_next: Vec[UInt] = Wire(Vec(7, UInt(83.W)))
  val c_reg_next: Vec[UInt] = Wire(Vec(6, UInt(83.W)))
  withClockAndReset(io.pipe1_clk, !io.cpurst_b) {
    val s_reg = RegInit(VecInit(Seq.fill(7)(0.U(83.W))))
    val c_reg = RegInit(VecInit(Seq.fill(6)(0.U(83.W))))
    s_reg_next := s_reg
    c_reg_next := c_reg
    when(io.pipe1_down) {
      for (i <- 0 to 5) {
        s_reg(i) := s1(i)
        c_reg(i) := c1(i)
      }
      s_reg(6) := part_product(33)(54, 0)
    }.otherwise {
      for (i <- 0 to 5) {
        s_reg(i) := s_reg(i)
        c_reg(i) := c_reg(i)
      }
      s_reg(6) := s_reg(6)
    }
  }
  //----------------------------------------------------------
  //                    L3 compressor
  //----------------------------------------------------------
  // third level compressor:
  // components: 3 4:2 compressor
  // result: 12 partial products -> 6 paritial products
  val r0, r1, r2, r3, r_cin, cout2 = Wire(Vec(3, UInt(93.W)))
  r0(0) := Seq(0.U(12.W), s_reg_next(0)(80, 0)).reduce(Cat(_, _))
  r1(0) := Seq(0.U(11.W), c_reg_next(0)(80, 0), 0.U(1.W)).reduce(Cat(_, _))
  r2(0) := Seq(0.U(3.W), s_reg_next(1)(82, 0), 0.U(7.W)).reduce(Cat(_, _))
  r3(0) := Seq(0.U(2.W), c_reg_next(1)(82, 0), 0.U(8.W)).reduce(Cat(_, _))
  r_cin(0) := Seq(0.U(2.W), cout2(0)(89, 0), 0.U(1.W)).reduce(Cat(_, _))


  r0(1) := Seq(0.U(10.W), s_reg_next(2)(82, 0)).reduce(Cat(_, _))
  r1(1) := Seq(0.U(9.W), c_reg_next(2)(82, 0), 0.U(1.W)).reduce(Cat(_, _))
  r2(1) := Seq(0.U(1.W), s_reg_next(3)(82, 0), 0.U(9.W)).reduce(Cat(_, _))
  r3(1) := Seq(c_reg_next(3)(82, 0), 0.U(10.W)).reduce(Cat(_, _))
  r_cin(1) := Seq(cout2(1)(91, 0), 0.U(1.W)).reduce(Cat(_, _))


  r0(2) := Seq(0.U(10.W), s_reg_next(4)(82, 0)).reduce(Cat(_, _))
  r1(2) := Seq(0.U(9.W), c_reg_next(4)(82, 0), 0.U(1.W)).reduce(Cat(_, _))
  r2(2) := Seq(0.U(9.W), s_reg_next(5)(74, 0), 0.U(9.W)).reduce(Cat(_, _))
  r3(2) := Seq(0.U(9.W), c_reg_next(5)(73, 0), 0.U(1.W), s_reg_next(6)(54, 46)).reduce(Cat(_, _))
  r_cin(2) := Seq(0.U(9.W), cout2(2)(82, 0), 0.U(1.W)).reduce(Cat(_, _))

  val s2, c2 = Wire(Vec(3, UInt(93.W)))
  val x_comp_3 = Seq.fill(3)(Module(new Compressor42(93)))
  for (i: Int <- 0 to 2) {
    x_comp_3(i).io.p0 := r0(i)
    x_comp_3(i).io.p1 := r1(i)
    x_comp_3(i).io.p2 := r2(i)
    x_comp_3(i).io.p3 := r3(i)
    s2(i) := x_comp_3(i).io.s
    c2(i) := x_comp_3(i).io.ca
    cout2(i) := x_comp_3(i).io.cout
  }
  //----------------------------------------------------------
  //                    L4 compressor
  //----------------------------------------------------------
  // forth level compressor:
  // components: 2 3:2 compressor
  // result: 6 partial products -> 4 paritial products
  val t0 = Wire(Vec(3, UInt(115.W)))
  val t1 = Wire(Vec(3, UInt(107.W)))

  t0(0) := Seq(0.U(24.W), s2(0)(90, 0)).reduce(Cat(_, _))
  t0(1) := Seq(0.U(23.W), c2(0)(90, 0), 0.U(1.W)).reduce(Cat(_, _))
  t0(2) := Seq(s2(1)(92, 0), 0.U(22.W)).reduce(Cat(_, _))


  t1(0) := Seq(0.U(14.W), c2(1)(92, 0)).reduce(Cat(_, _))
  t1(1) := Seq(s2(2)(83, 0), 0.U(23.W)).reduce(Cat(_, _))
  t1(2) := Seq(c2(2)(82, 0), 0.U(1.W), s_reg_next(6)(45, 23)).reduce(Cat(_, _))


  val s3_0, c3_0 = Wire(UInt(115.W))
  val s3_1, c3_1 = Wire(UInt(107.W))

  val x_comp3_0 = Module(new Compressor32(115))
  val x_comp3_1 = Module(new Compressor32(107))

  x_comp3_0.io.a := t0(0)
  x_comp3_0.io.b := t0(1)
  x_comp3_0.io.cin := t0(2)
  s3_0 := x_comp3_0.io.s
  c3_0 := x_comp3_0.io.ca

  x_comp3_1.io.a := t1(0)
  x_comp3_1.io.b := t1(1)
  x_comp3_1.io.cin := t1(2)
  s3_1 := x_comp3_1.io.s
  c3_1 := x_comp3_1.io.ca
  //----------------------------------------------------------
  //                    L5 compressor
  //----------------------------------------------------------
  // fifth level compressor:
  // components: 1 4:2 compressor
  // result: 4 partial products -> 2 paritial products
  val v0 = Wire(Vec(4, UInt(130.W)))
  val v0_cin,cout4_0 = Wire(UInt(130.W))

  v0(0) := Seq(0.U(15.W), s3_0).reduce(Cat(_, _))
  v0(1) := Seq(0.U(14.W), c3_0, 0.U(1.W)).reduce(Cat(_, _))
  v0(2) := Seq(s3_1(106, 0), 0.U(23.W)).reduce(Cat(_, _))
  v0(3) := Seq(c3_1(105, 0), 0.U(1.W),s_reg_next(6)(22,0)).reduce(Cat(_, _))
  v0_cin := Seq(cout4_0(128, 0), 0.U(1.W)).reduce(Cat(_, _))

  val s4_0,c4_0 = Wire( UInt(130.W))
  val x_comp4_1 = Module(new Compressor42(130))
  x_comp4_1 .io.p0 := v0(0)
  x_comp4_1 .io.p1 := v0(1)
  x_comp4_1 .io.p2 := v0(2)
  x_comp4_1 .io.p3 := v0(3)
  s4_0 := x_comp4_1 .io.s
  c4_0 := x_comp4_1 .io.ca
  cout4_0 := x_comp4_1 .io.cout

  val w0 = Wire(Vec(3, UInt(64.W)))
  val sum_wire,carry_wire = Wire(UInt(130.W))
  withClockAndReset(io.pipe2_clk, !io.cpurst_b) {
    val sum,carry = RegInit((0.U(130.W)))
    val addend_reg = RegInit((0.U(64.W)))
    w0(0) := sum(63,0)
    w0(1) := Cat(carry(62,0),0.U(1.W))
    w0(2) := addend_reg(63,0)
    sum_wire := sum
    carry_wire := carry
    when(io.pipe2_down) {
      sum := s4_0
      carry := c4_0
      addend_reg := io.addend
    }.otherwise {
      sum := sum
      carry := carry
      addend_reg := addend_reg
    }
  }
  //----------------------------------------------------------
  //                    L6 compressor
  //----------------------------------------------------------
  // sixth level compressor:
  // components: 1 3:2 compressor
  // result: 3 partial products -> 2 paritial products
  val s5_0,c5_0,product_mult_add = Wire( UInt(64.W))
  val product_mult = Wire( UInt(130.W))
  val x_comp5_0 = Module(new Compressor32(64))
  product_mult :=  sum_wire + Cat(carry_wire(128,0),0.U(1.W))
  product_mult_add := s5_0(63,0) + Cat(c5_0(62,0),0.U(1.W))
  x_comp5_0.io.a := w0(0)
  x_comp5_0.io.b := w0(1)
  x_comp5_0.io.cin := w0(2)
  s5_0 := x_comp5_0.io.s
  c5_0 := x_comp5_0.io.ca
  io.product := Cat(product_mult(129,64),product_mult_add(63,0))

}
object generator extends App{
  (new ChiselStage).emitVerilog(new multiplier_65_65_3_stage(),Array("--target-dir",s"generated/GCD"))
}
