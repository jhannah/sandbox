package lecture2_7

object lecture2_7 {
	// infix operators
	// x.add(b)    can be written as   x add b
	
	val x = new Rational(1, 3)                //> x  : lecture2_7.Rational = 1/3
	val y = new Rational(5, 7)                //> y  : lecture2_7.Rational = 5/7
	val z = new Rational(3, 2)                //> z  : lecture2_7.Rational = 3/2
	x - y - z                                 //> res0: lecture2_7.Rational = -79/42
	y + z                                     //> res1: lecture2_7.Rational = 31/14
	x < y                                     //> res2: Boolean = true
	x max y                                   //> res3: lecture2_7.Rational = 5/7
	new Rational(2)                           //> res4: lecture2_7.Rational = 2/1
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
	def < (that: Rational) = numer * that.denom < that.numer * denom
	def max(that: Rational) = if (this < that) that else this
	def + (that: Rational) =
		new Rational(
			numer * that.denom + that.numer * denom,
			denom * that.denom)
	def unary_- : Rational = new Rational(- numer, denom)
	def - (that: Rational) = this + -that
	override def toString = numer + "/" + denom
}


/*
Precedence:
	a + b ^? c ?^ d less a ==> b | c
	((a + b) ^? (c ?^ d)) less ((a ==> b) | c)
	
Scala precedence in increasing order:
(all letters)
|
^
&
< >
= !
:
+ -
* / %
(all other special characters)

*/