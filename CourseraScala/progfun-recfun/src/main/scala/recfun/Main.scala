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
    denoms.size    
  }
}
