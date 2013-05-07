package forcomp

import common._

object sandbox {
  type Word = String
  type Sentence = List[Word]
  type Occurrences = List[(Char, Int)]
  // val dictionary: List[Word] = loadDictionary
  
  def wordOccurrences(w: Word): Occurrences =
    w.toLowerCase.toList.groupBy(x => x).mapValues(x => x.length).toList.sortBy{_._1}
                                                  //> wordOccurrences: (w: forcomp.sandbox.Word)forcomp.sandbox.Occurrences
    
  1 + 1                                           //> res0: Int(2) = 2
  // Why the fuck doesn't this work in a Worksheet?
  // List("Every", "student", "likes", "Scala").groupBy((element String) => element.length)
  "abc".toList                                    //> res1: List[Char] = List(a, b, c)
  
  List("dog", "cat", "ant").groupBy(x => x.length)//> res2: scala.collection.immutable.Map[Int,List[String]] = Map(3 -> List(dog, 
                                                  //| cat, ant))
  
  // dictionary.map(x => (x, x.length))
  //dictionary.groupBy(x => wordOccurrences(x))
   (List(('a', 2), ('b', 2)))                     //> res3: List[(Char, Int)] = List((a,2), (b,2))
   
   val x = 5                                      //> x  : Int = 5
   val y = 1 until x + 1                          //> y  : scala.collection.immutable.Range = Range(1, 2, 3, 4, 5)
   List.fill(10)(1)                               //> res4: List[Int] = List(1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
   for (x <- 1 to 4; y <- 10 to 13) yield x -> y  //> res5: scala.collection.immutable.IndexedSeq[(Int, Int)] = Vector((1,10), (1,
                                                  //| 11), (1,12), (1,13), (2,10), (2,11), (2,12), (2,13), (3,10), (3,11), (3,12),
                                                  //|  (3,13), (4,10), (4,11), (4,12), (4,13))
   
   //val z = for( a <- 1 until 10 + 1 ) {
   //  a
   //}
}