package lecture2_2

object sandbox {
  // ---------------------------------------------
  // Lecture 2.2 - Currying
  // ---------------------------------------------
  def sum(f: Int => Int, a: Int, b: Int): Int = {
		def loop(a: Int, acc: Int): Int = {
			if (a > b) acc
			else loop(a + 1, acc + f(a))
		}
		loop (a, 0)
	}                                         //> sum: (f: Int => Int, a: Int, b: Int)Int
  
  
	def sumInts(a: Int, b: Int)  = sum(x => x, a, b)
                                                  //> sumInts: (a: Int, b: Int)Int
	def sumCubes(a: Int, b: Int) = sum(x => x * x * x, a, b)
                                                  //> sumCubes: (a: Int, b: Int)Int
	
	sumInts(3,5)                              //> res0: Int = 12
	sumCubes(1,3)                             //> res1: Int = 36
	
}