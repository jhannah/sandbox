object sandbox {
  import recfun.Main._
  "what".toList                                   //> res0: List[Char] = List(w, h, a, t)
  balance("aaaa)aaa".toList)                      //> res1: Boolean = false
  balance("aaa(a)aaa".toList)                     //> res2: Boolean = true
  27 / 10                                         //> res3: Int(2) = 2
  27 % 10                                         //> res4: Int(7) = 7
 
  def List1 = (1,2)                               //> List1: => (Int, Int)
    
    0 to 3                                        //> res5: scala.collection.immutable.Range.Inclusive = Range(0, 1, 2, 3)
    3 to 1 by -1                                  //> res6: scala.collection.immutable.Range = Range(3, 2, 1)
    
  countChange(4, List(2, 1))                      //> 1 2s (money_left is 2, sol_cnt is 0)
                                                  //| 1 1s (money_left is 1, sol_cnt is 0)
                                                  //| done. money is 1
                                                  //| 2 1s (money_left is 0, sol_cnt is 0)
                                                  //| done. money is 0
                                                  //| done. money is 2
                                                  //| 2 2s (money_left is 0, sol_cnt is 0)
                                                  //| done. money is 0
                                                  //| 1 1s (money_left is 3, sol_cnt is 0)
                                                  //| done. money is 3
                                                  //| 2 1s (money_left is 2, sol_cnt is 0)
                                                  //| done. money is 2
                                                  //| 3 1s (money_left is 1, sol_cnt is 0)
                                                  //| done. money is 1
                                                  //| 4 1s (money_left is 0, sol_cnt is 0)
                                                  //| done. money is 0
                                                  //| done. money is 4
                                                  //| res7: Int = 0
  
  1 to 0                                          //> res8: scala.collection.immutable.Range.Inclusive = Range()
  
}