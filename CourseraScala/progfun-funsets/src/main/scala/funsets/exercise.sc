package funsets

import FunSets._

object exercise {
	val s1 = singletonSet(1)                  //> s1  : Int => Boolean = <function1>
  val s2 = singletonSet(2)                        //> s2  : Int => Boolean = <function1>
  s1                                              //> res0: Int => Boolean = <function1>
  val s10 = union(s1, s2)                         //> union here
                                                  //| s10  : Int => Boolean = <function1>
  contains(s10, 1)                                //> res1: Boolean = true
  contains(s10, 2)                                //> res2: Boolean = true
  contains(s10, 3)                                //> res3: Boolean = false
}