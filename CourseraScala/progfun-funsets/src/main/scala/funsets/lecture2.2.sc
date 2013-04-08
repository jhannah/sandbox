package lecture2_2

object sandbox {
  // ---------------------------------------------
  // Lecture 2.2 - Currying
  // ---------------------------------------------
  def sum(f: Int => Int): (Int, Int) => Int = {
		def sumF(a: Int, b: Int): Int =
			if (a > b) 0
			else f(a) + sumF(a + 1, b)
		sumF
	}                                         //> sum: (f: Int => Int)(Int, Int) => Int
  def sumInts       = sum(x => x)                 //> sumInts: => (Int, Int) => Int
  def sumCubes      = sum(x => x * x * x)         //> sumCubes: => (Int, Int) => Int
  
  // factorial_w_tail_recursion
	def fact(n: Int): Int = {
		def loop(acc: Int, n: Int): Int =
			if (n == 0) acc
			else loop(acc * n, n - 1)
		loop(1, n)
	}                                         //> fact: (n: Int)Int
  
  def sumFactorials = sum(fact)                   //> sumFactorials: => (Int, Int) => Int
  
	sumInts(3,5)                              //> res0: Int = 12
	sumCubes(1,3)                             //> res1: Int = 36
	// 1 + 8 + 27 = 36
	
	fact(3)                                   //> res2: Int = 6
	sumCubes(1, 10) + sumFactorials(10, 20)   //> res3: Int = 267634641
}

object exercise {
	def product(f: Int => Int)(a: Int, b: Int): Int =
		if (a > b) 1
		else f(a) * product(f)(a + 1, b)
	product(x => x * x)(3, 4)
}