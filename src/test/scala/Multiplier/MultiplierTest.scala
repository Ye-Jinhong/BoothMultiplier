package Multiplier

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import chisel3.stage.ChiselStage

import scala.util.Random

class MultiplierTest extends AnyFreeSpec with ChiselScalatestTester {
  "Calculate should pass" in {
    val multiplier: Long = Random.nextLong(1 << 20)
//    val multiplier = 0
    println(s"multiplier = ${multiplier}")
    val multiplicand: Long = Random.nextLong(1 << 20)
//    val multiplicand = 0
    println(s"multiplicand = ${multiplicand}")
    val product: Long = multiplier * multiplicand
    println(s"product = ${product}")
    test(new Multiplier()){ c =>
      c.io.multiplier.poke(multiplier.asUInt)
      c.io.multiplicand.poke(multiplicand.asUInt)
      c.io.sub_vld.poke(false.B)
      c.clock.step(1)
      c.io.product.expect(product.asUInt)
    }
  }
  (new ChiselStage).emitVerilog(new Multiplier(), Array("-td", "generated", "--full-stacktrace"))
}