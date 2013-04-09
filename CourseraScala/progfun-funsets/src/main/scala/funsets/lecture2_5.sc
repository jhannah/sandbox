package lecture2_5

object lecture2_5 {
	val x = new Rational(1, 2)                //> x  : lecture2_5.Rational = lecture2_5.Rational@74b23210
	x.numer                                   //> res0: Int = 1
	x.denom                                   //> res1: Int = 2
	
	def addRational(r: Rational, s: Rational): Rational =
		new Rational(
			r.numer * s.denom + s.numer * r.denom,
			r.denom * s.denom)        //> addRational: (r: lecture2_5.Rational, s: lecture2_5.Rational)lecture2_5.Rati
                                                  //| onal
	def makeString(r: Rational) =
		r.numer + "/" + r.denom           //> makeString: (r: lecture2_5.Rational)String
		
	makeString(addRational(new Rational(1, 2), new Rational(2, 3)))
                                                  //> res2: String = 7/6
                                                  
  // ----------------
  // Lets get OOier now with Rational2
  val x2 = new Rational2(1, 2)                    //> x2  : lecture2_5.Rational2 = 1/2
  val y2 = new Rational2(2, 3)                    //> y2  : lecture2_5.Rational2 = 2/3
  x2.add(y2)                                      //> res3: lecture2_5.Rational2 = 7/6
  x2.neg()                                        //> res4: lecture2_5.Rational2 = -1/2
  x2.sub(y2)                                      //> res5: lecture2_5.Rational2 = -1/6
  
  // Exercise
  val x3 = new Rational2(1, 3)                    //> x3  : lecture2_5.Rational2 = 1/3
  val y3 = new Rational2(5, 7)                    //> y3  : lecture2_5.Rational2 = 5/7
  val z3 = new Rational2(3, 2)                    //> z3  : lecture2_5.Rational2 = 3/2
  x3.sub(y3).sub(z3)                              //> res6: lecture2_5.Rational2 = -79/42
}

class Rational(x: Int, y: Int) {
	def numer = x
	def denom = y
}

// Lets get OOier now:
class Rational2(x: Int, y: Int) {
	def numer = x
	def denom = y
	
	def add(that: Rational2) =
		new Rational2(
			numer * that.denom + that.numer * denom,
			denom * that.denom)
	def neg() = new Rational2(- numer, denom)
	def sub(that: Rational2) = this.add(that.neg)
	override def toString = numer + "/" + denom
}