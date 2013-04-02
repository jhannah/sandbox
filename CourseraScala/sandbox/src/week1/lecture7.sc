package week1

// https://class.coursera.org/progfun-002/lecture/7
object lecture7 {
  1 + 3                                           //> res0: Int(4) = 4
  def abs(x: Double) = if (x < 0) -x else x       //> abs: (x: Double)Double

  def sqrt(x: Double) = {
  
    def sqrtIter(guess: Double, x: Double): Double =
      if (isGoodEnough(guess, x)) guess
      else sqrtIter(improve(guess, x), x)
  
    def isGoodEnough(guess: Double, x: Double) =
      abs(guess * guess - x) / x < 0.001

    def improve(guess: Double, x: Double) =
      (guess + x / guess) / 2

    sqrtIter(1.0, x)
  }                                               //> sqrt: (x: Double)Double

  sqrt(2)                                         //> res1: Double = 1.4142156862745097
  sqrt(7)                                         //> res2: Double = 2.64576704419029
  sqrt(1e-6)                                      //> res3: Double = 0.0010000001533016628
  sqrt(1e60)                                      //> res4: Double = 1.0000788456669446E30


	val x = 0                                 //> x  : Int = 0
	def f(y: Int) = y + 1                     //> f: (y: Int)Int
	val result = {
		val x = f(3); x * x
	} + x                                     //> result  : Int = 16
	

	// ---------------------------------------
	// Now that we're in a block x is available everywhere in the block, so the above code can be reduced:
	def sqrt_simpler(x: Double) = {
  
    def sqrtIter(guess: Double): Double =
      if (isGoodEnough(guess)) guess
      else sqrtIter(improve(guess))
  
    def isGoodEnough(guess: Double) =
      abs(guess * guess - x) / x < 0.001

    def improve(guess: Double) =
      (guess + x / guess) / 2

    sqrtIter(1.0)
  }                                               //> sqrt_simpler: (x: Double)Double
  sqrt_simpler(7)                                 //> res5: Double = 2.64576704419029
	// ---------------------------------------
  
}