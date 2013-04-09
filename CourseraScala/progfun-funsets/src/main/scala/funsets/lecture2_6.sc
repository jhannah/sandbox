package lecture2_6

object lecture2_6 {
	val x = new Rational(1, 3)                //> x  : lecture2_6.Rational = 1/3
	val y = new Rational(5, 7)                //> y  : lecture2_6.Rational = 5/7
	val z = new Rational(3, 2)                //> z  : lecture2_6.Rational = 3/2
	x.sub(y).sub(z)                           //> res0: lecture2_6.Rational = -79/42
	y.add(y)                                  //> res1: lecture2_6.Rational = 10/7
	x.less(y)                                 //> res2: Boolean = true
	x.max(y)                                  //> res3: lecture2_6.Rational = 5/7
	// val strange = new Rational(1, 0)
	// strange.add(strange)
	new Rational(2)                           //> res4: lecture2_6.Rational = 2/1
}

class Rational(x: Int, y: Int) {
	require(y != 0, "denominator must be nonzero")
	// vs. "assert", which is for internal problems
	
	// 2nd constructor for a single argument:
	def this(x: Int) = this(x, 1)
	
	// greatest common denominator
	private def gcd(a: Int, b: Int): Int = if (b == 0) a else gcd(b, a % b)
	private val g = gcd(x, y)
	def numer = x / g
	def denom = y / g
	def less(that: Rational) = numer * that.denom < that.numer * denom
	def max(that: Rational) = if (this.less(that)) that else this
	def add(that: Rational) =
		new Rational(
			numer * that.denom + that.numer * denom,
			denom * that.denom)
	def neg: Rational = new Rational(- numer, denom)
	def sub(that: Rational) = add(that.neg)
	override def toString = numer + "/" + denom
}