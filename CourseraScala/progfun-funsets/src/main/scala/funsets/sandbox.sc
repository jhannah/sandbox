package funsets

object sandbox {
/*
  // ---------------------------------------------
  // Lecture 2.1 - Higher-Order Functions
  // ---------------------------------------------
	def sumInts(a: Int, b: Int): Int =
	  if (a > b) 0 else a + sumInts(a + 1, b)
	sumInts(3,5)
	
	
	def cube(x: Int): Int = x * x * x
	def sumCubes(a: Int, b: Int): Int =
	  if (a > b) 0 else cube(a) + sumCubes(a + 1, b)
	sumCubes(1,3)
	// 1 + 8 + 27
	// 36
	
	// -----------------------------
	def sum(f: Int => Int, a: Int, b: Int): Int =
		if (a > b) 0
		else f(a) + sum(f, a + 1, b)
	def sumInts(a: Int, b: Int)       = sum(id, a, b)
	def sumCubes(a: Int, b: Int)      = sum(cube, a, b)
	def sumFactorials(a: Int, b: Int) = sum(fact, a, b)
	def id(x: Int): Int   = x
	def cube(x: Int): Int = x * x * x
	def fact(x: Int): Int = if (x == 0) 1 else fact(x - 1)
	sumCubes(1,3)
*/
	
	// -----------------------------
	// Anonymous function: x => x
	def sum(f: Int => Int, a: Int, b: Int): Int =
		if (a > b) 0
		else f(a) + sum(f, a + 1, b)      //> sum: (f: Int => Int, a: Int, b: Int)Int
	def sumInts(a: Int, b: Int)  = sum(x => x, a, b)
                                                  //> sumInts: (a: Int, b: Int)Int
	def sumCubes(a: Int, b: Int) = sum(x => x * x * x, a, b)
                                                  //> sumCubes: (a: Int, b: Int)Int
	
	sumInts(3,5)                              //> res0: Int = 12
	sumCubes(1,3)                             //> res1: Int = 36
	
}