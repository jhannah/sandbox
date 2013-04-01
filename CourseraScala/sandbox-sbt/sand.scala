object Sand { 

	def square(x: Double) = x * x

	def sumOfSquares(x: Double, y: Double) = square(x) + square(y)

	def abs(x: Int) = if (x >= 0) x else -x

	def loop: Boolean = loop

/* -----------------------------------------------------------
	From https://class.coursera.org/progfun-002/lecture/5
	-----------------------------------------------------------
So with Booleans this 'and' (&&) implementation would be fine:          */
	def and1(x: Boolean, y: Boolean) = 
		if (x) y else false
/* 
But that will hang on 
		and(false, loop) 
So we change y from "pass by parameter" to "pass by expression" (call-by-name):
*/
	def and2(x: Boolean, y: => Boolean) = 
		if (x) y else false
// Here's a convenience pointer to the one that works:
	def and(x: Boolean, y: => Boolean): Boolean = and2(x, y)
	// -----------------------------------------------------------


/* -----------------------------------------------------------
	From https://class.coursera.org/progfun-002/lecture/6
	-----------------------------------------------------------       
	def sqrt(x: Double): Double = ???
   // Recursive functions always require an explicit return type.
	def sqrtIter(guess: Double, x: Double): Double = 
		if (isGoodEnough(guess, x)) guess
		else sqrtIter(improve(guess, x), x)
*/

}


