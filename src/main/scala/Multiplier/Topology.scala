package Multiplier

trait Topology {
  val w = 65
  val odd: Boolean = w % 2 == 1
  val n: Int = if (odd) (w + 1) / 2 else w / 2
  val topologyArray: Array[Array[Int]] = Array(
    Array(1, 2, 3),
    Array(1, 23, 5)
  )
}