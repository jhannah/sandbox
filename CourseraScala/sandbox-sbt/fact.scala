import scala.annotation.tailrec
// http://www.scala-lang.org/api/current/index.html#scala.annotation.tailrec

@tailrec
def fact (n: Int, a: Int = 1): Int =
  if (n < 2) a else fact(n - 1, a * n)

println(fact(5))


