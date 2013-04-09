package sandbox2

import math.abs

object sandbox2 {
	val tolerance = 0.0001                    //> tolerance  : Double = 1.0E-4
	def isCloseEnough(x: Double, y: Double) =
		abs((x - y) / x) / x < tolerance  //> isCloseEnough: (x: Double, y: Double)Boolean
	def fixedPoint(f: Double => Double)(firstGuess: Double) = {
		def iterate(guess: Double): Double = {
			println("guess = " + guess)
			val next = f(guess)
			if (isCloseEnough(guess, next)) next
			else iterate(next)
		}
		iterate(firstGuess)
	}                                         //> fixedPoint: (f: Double => Double)(firstGuess: Double)Double
	def averageDamp(f: Double => Double)(x: Double) = (x + f(x)) / 2
                                                  //> averageDamp: (f: Double => Double)(x: Double)Double
	def sqrt3(x: Double) =
		fixedPoint(averageDamp(y => x / y))(1)
                                                  //> sqrt3: (x: Double)Double
	sqrt3(2)                                  //> guess = 1.0
                                                  //| guess = 1.5
                                                  //| guess = 1.4166666666666665
                                                  //| guess = 1.4142156862745097
                                                  //| res0: Double = 1.4142135623746899
	
}