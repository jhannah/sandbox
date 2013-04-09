package sandbox

object sandbox {
	def product(f: Int => Int)(a: Int, b: Int): Int = {
		println("hi " + a + " " + b)
		if (a > b) 1
		else f(a) * product(f)(a + 1, b)
  }                                               //> product: (f: Int => Int)(a: Int, b: Int)Int
	// product(x => x * x)(3, 4)
	
	def fact(n: Int) = product(x => x)(1, n)  //> fact: (n: Int)Int
	fact(5)                                   //> hi 1 5
                                                  //| hi 2 5
                                                  //| hi 3 5
                                                  //| hi 4 5
                                                  //| hi 5 5
                                                  //| hi 6 5
                                                  //| res0: Int = 120
	
}