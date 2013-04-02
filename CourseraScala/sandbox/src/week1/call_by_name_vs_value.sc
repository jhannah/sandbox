package week1

object call_by_name_vs_value {
  // http://omgo.wordpress.com/2010/06/07/scala-call-by-name-vs-call-by-type/
  def byName(a: => Unit) = {
    for (i <- 0 until 10) { println(a) }
  }                                               //> byName: (a: => Unit)Unit

  def byValue(a: Unit) = {
    for (i <- 0 until 10) { println(a) }
  }                                               //> byValue: (a: Unit)Unit

  var i = 1                                       //> i  : Int = 1

  byValue(i = i + 1)                              //> ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
  println(i)                                      //> 2

  byName(i = i + 1)                               //> ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
                                                  //| ()
  println(i)                                      //> 12
}