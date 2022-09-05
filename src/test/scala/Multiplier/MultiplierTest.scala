package Multiplier

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import chisel3.stage.ChiselStage

import scala.util.Random

class MultiplierTest extends AnyFreeSpec with ChiselScalatestTester with BaseData {
  "Calculate should pass" in {
    val multiplier: Long = Random.nextInt
//    val multiplier = -1
    println(s"multiplier = ${multiplier}")
    val multiplicand: Long = Random.nextInt
//    val multiplicand = -1
    println(s"multiplicand = ${multiplicand}")
    val product: Long = multiplier * multiplicand
    println(s"product = ${product}")
    test(new Multiplier()){ c =>
      c.io.multiplier.poke(multiplier.asSInt(w.W))
      c.io.multiplicand.poke(multiplicand.asSInt(w.W))
      c.io.sub_vld.poke(false.B)
      c.io.addend.poke(0.asSInt)
      c.clock.step(1)
      c.io.product.expect(product.asSInt((2*w).W))
    }
  }
  (new ChiselStage).emitVerilog(new Multiplier(), Array("-td", "generated", "--full-stacktrace"))
}