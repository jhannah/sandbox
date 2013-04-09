package mycurry

object mycurry {
	// http://www.codecommit.com/blog/scala/function-currying-in-scala
	def process[A](filter:A=>Boolean)(list:List[A]):List[A] = {
  	lazy val recurse = process(filter) _
 
  	list match {
    	case head::tail => if (filter(head)) {
				head::recurse(tail)
    	} else {
    	  recurse(tail)
  	  }
			case Nil => Nil
		}
	}                                         //> process: [A](filter: A => Boolean)(list: List[A])List[A]
 
	val even = (a:Int) => a % 2 == 0          //> even  : Int => Boolean = <function1>
 
	val numbersAsc = 1::2::3::4::5::Nil       //> numbersAsc  : List[Int] = List(1, 2, 3, 4, 5)
	val numbersDesc = 5::4::3::2::1::Nil      //> numbersDesc  : List[Int] = List(5, 4, 3, 2, 1)
 
	process(even)(numbersAsc)                 //> res0: List[Int] = List(2, 4)
	process(even)(numbersDesc)                //> res1: List[Int] = List(4, 2)

}