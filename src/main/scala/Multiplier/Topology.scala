package Multiplier

trait BaseData {
  val w = 65
  val odd: Boolean = w % 2 == 1
  val n: Int = if (odd) (w + 1) / 2 else w / 2

}

trait Topology {
  val connectArray: Array[Int] = Array(0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7)
  val topologyArray: Array[Array[Int]] = Array(
    Array(1, 2, 3),
    Array(1, 23, 5)
  )
}