object sandbox {
  import recfun.Main._
  "what".toList                                   //> res0: List[Char] = List(w, h, a, t)
  balance("aaaa)aaa".toList)                      //> res1: Boolean = false
  balance("aaa(a)aaa".toList)                     //> res2: Boolean = true
  27 / 10                                         //> res3: Int(2) = 2
  27 % 10                                         //> res4: Int(7) = 7
 
  def List1 = (1,2)                               //> List1: => (Int, Int)
    
    
  countChange(107, List(10, 5))                   //> 10 10s
                                                  //| 1 5s
                                                  //| res5: Int = 0
  
  
}