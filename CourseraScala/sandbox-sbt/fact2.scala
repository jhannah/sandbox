  def countChange(money: Int, denoms: List[Int]): Int = {
    def loop(sol_cnt: Int, money: Int, denoms: List[Int]): Int = {
      if (denoms.isEmpty) 
        if (money == 0) sol_cnt + 1 
        else sol_cnt
      else {
        val this_denom = denoms.head
        val max_quant = money / this_denom
        for (q <- 0 to max_quant) {
          val money_left = money - (this_denom * q)
          println(q + " " + this_denom + "s")
          loop(sol_cnt, money_left, denoms.tail)
        }
      }
    }
    loop(0, money, denoms)
  }



