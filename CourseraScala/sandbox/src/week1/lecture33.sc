package week1

object lecture33 {
	// https://class.coursera.org/progfun-002/lecture/33
	// Lecture 1.7 - Tail Recursion
	 
	def gcd(a: Int, b: Int): Int =
		if (b == 0) a else gcd(b, a % b)  //> gcd: (a: Int, b: Int)Int
		
	gcd(400, 150)                             //> res0: Int = 50
	gcd(14, 21)                               //> res1: Int = 7

	23 % 10                                   //> res2: Int(3) = 3

	// ------------------
  
	def factorial(n: Int): Int =
		if (n == 0) 1 else n * factorial(n - 1)
                                                  //> factorial: (n: Int)Int
  	
	factorial(4)                              //> res3: Int = 24



	// Tail recursive functions (calls itself as last action) execute in constant space
	// above gcd() is tail recursive, factorial() is not


	def factorial_w_tail_recursion(n: Int): Int = {
		def loop(acc: Int, n: Int): Int =
			if (n == 0) acc
			else loop(acc * n, n - 1)
 		loop(1, n)
 	}                                         //> factorial_w_tail_recursion: (n: Int)Int
	factorial_w_tail_recursion(4)             //> res4: Int = 24
	
	
	
	/*
  // So... for whatever reason, Scala Worksheets don't like this...
  // See sandbox-sbt/fact.scala for command-line version that work fine.
  
	import scala.annotation.tailrec
	@tailrec
	def fact (n: Int, a: Int = 1): Int =
		if (n < 2) a else fact(n - 1, a * n)
	println(fact(5))
	
	*/
	
	
}