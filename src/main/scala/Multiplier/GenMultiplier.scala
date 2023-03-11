package Multiplier

import chisel3.stage.ChiselStage

object GenMultiplier extends App {
  (new ChiselStage).emitVerilog(Multiplier(), Array("-td", "generated", "--full-stacktrace"))
}