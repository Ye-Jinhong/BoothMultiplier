package Multiplier

import chisel3.stage.ChiselStage

object GenMultiplier extends App with BaseData {
  require(!debugFlag)
  (new ChiselStage).emitVerilog(Multiplier(), Array("-td", "generated", "--full-stacktrace"))
}