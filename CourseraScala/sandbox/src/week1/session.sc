package week1

object session {
	println("Welcome to the Scala worksheet") //> Welcome to the Scala worksheet
	def x = 3 - 32                            //> x: => Int
	def abs(x: Double) = if (x < 0) -x else x //> abs: (x: Double)Double
	def loop: Boolean = loop                  //> loop: => Boolean
	abs(x)                                    //> res0: Double = 29.0

	// ---------------------------------------------------------
	// https://class.coursera.org/progfun-002/lecture/6
	def sqrt(x: Double) = sqrtIter(1.0, x)    //> sqrt: (x: Double)Double
	
	def sqrtIter(guess: Double, x: Double): Double =
		if (isGoodEnough(guess, x)) guess
		else sqrtIter(improve(guess, x), x)
                                                  //> sqrtIter: (guess: Double, x: Double)Double
		
	def isGoodEnough(guess: Double, x: Double) =
		// abs(guess * guess - x) < 0.001   // Broken for very large, very small numbers below.
		abs(guess * guess - x) / x < 0.001//> isGoodEnough: (guess: Double, x: Double)Boolean
    
	def improve(guess: Double, x: Double) =
		(guess + x / guess) / 2           //> improve: (guess: Double, x: Double)Double
	
	sqrt(2)                                   //> res1: Double = 1.4142156862745097
	sqrt(7)                                   //> res2: Double = 2.64576704419029
	sqrt(1e-6)                                //> res3: Double = 0.0010000001533016628
	// Infinite loop creates an ASCII swirly thing! LOL
	// sqrt(1e60)
	// Hit Esc to exit
	// loop
	
	// 1e60
	// 1e60 + 2 / 1e60
	sqrt(0.001)                               //> res4: Double = 0.03162278245070105
	sqrt(0.1e-20)                             //> res5: Double = 3.1633394544890125E-11
	sqrt(1.0e20)                              //> res6: Double = 1.0000021484861237E10
	sqrt(1.0e50)                              //> res7: Double = 1.0000003807575104E25
}