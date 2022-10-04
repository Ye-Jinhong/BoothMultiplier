package Multiplier

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import chisel3.stage.ChiselStage

import scala.util.Random

class MultiplierTest extends AnyFreeSpec with ChiselScalatestTester with BaseData {
  "Calculate should pass" in {
    val sub: Boolean = (Random.nextInt() % 2 == 1)
//    val sub = true
//    println(s"sub = ${sub}")
    val multiplier: Long = Random.nextInt()
//    val multiplier = -1
//    println(s"multiplier = ${multiplier}")
    val multiplicand: Long = Random.nextInt()
//    val multiplicand = -1
//    println(s"multiplicand = ${multiplicand}")
    val addend: Int = Random.nextInt()
//    println(s"addend = ${addend}")
    val product: Long = if(!sub) multiplier * multiplicand + addend else addend - multiplier * multiplicand
//    println(s"product = ${product}")
    test(new Multiplier()){ c =>
      println(s"${c.cTypes}")
      c.io.multiplier.poke(multiplier.asSInt(w.W))
      c.io.multiplicand.poke(multiplicand.asSInt(w.W))
      c.io.sub_vld.poke(sub.B)
      c.io.addend.poke(addend.asSInt((w-1).W))
      if (c.isPipeline) {
        for(i <- c.pipeline.indices){
          c.clock.step(1)
          c.io.down(i).poke(true.B)
        }
        c.clock.step(1)
      }
      c.clock.step(1)
      c.io.product.expect(product.asSInt((2*w).W))
    }
  }
  (new ChiselStage).emitVerilog(Multiplier(), Array("-td", "generated", "--full-stacktrace"))
}