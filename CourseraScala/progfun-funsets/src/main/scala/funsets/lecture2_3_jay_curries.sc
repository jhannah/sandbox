package lecture2_3_jay_curries

object lecture2_3_jay_curries {
  def add1(x: Int) = (y: Int) => x + y            //> add1: (x: Int)Int => Int
  add1(5)(10)                                     //> res0: Int = 15
  
  
}