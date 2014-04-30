package recfun
import common._

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
   * Exercise 1
   */
  def pascal(c: Int, r: Int): Int =
    if (c == 0) 1 else
    if (c == r) 1 else
    pascal(c - 1, r - 1) + pascal(c, r - 1)
  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean = {
    def loop(open_count: Int, chars: List[Char]): Boolean = {
      // println(open_count + " " + chars.isEmpty + " " + chars.toString)
      if (open_count < 0)    false else
      if (chars.isEmpty)     open_count == 0 else
      if (chars.head == '(') loop(open_count + 1, chars.tail) else
      if (chars.head == ')') loop(open_count - 1, chars.tail) else
      loop(open_count, chars.tail)
    }
    loop(0, chars)
  }

  /**
   * Exercise 3
   */
  def countChange(money: Int, denoms: List[Int]): Int = {
    var sol_cnt = 0
    def loop(money: Int, denoms: List[Int]): Int = {
      if (denoms.isEmpty)
        if (money == 0) {
          println("done. money is " + money)
          sol_cnt = sol_cnt + 1;
          return 1;
        } else {
          println("done. money is " + money)
          1;
        }
      else {
        val this_denom = denoms.head
        val max_quant = money / this_denom
        for (q <- 1 to max_quant) {
          val money_left = money - (this_denom * q)
          println(q + " " + this_denom + "s " +
            "(money_left is " + money_left +
            ", sol_cnt is " + sol_cnt + ")"
          )
          loop(money_left, denoms.tail)
        }
        loop(money, denoms.tail)
      }
    }
    loop(money, denoms)
    return sol_cnt;
  }
}
