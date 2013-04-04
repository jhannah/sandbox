package example

import Lists._

object sandbox {
   1 to 7                                         //> res0: scala.collection.immutable.Range.Inclusive = Range(1, 2, 3, 4, 5, 6, 7)
                                                  //| 
   sum(List(7,2,0))                               //> res1: Int = 9
   max(List(2,7,0))                               //> res2: Int = 7
   max(List())                                    //> java.util.NoSuchElementException
                                                  //| 	at example.Lists$.max(Lists.scala:45)
                                                  //| 	at example.sandbox$$anonfun$main$1.apply$mcV$sp(example.sandbox.scala:9)
                                                  //| 
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$$anonfun$$exe
                                                  //| cute$1.apply$mcV$sp(WorksheetSupport.scala:76)
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$.redirected(W
                                                  //| orksheetSupport.scala:65)
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$.$execute(Wor
                                                  //| ksheetSupport.scala:75)
                                                  //| 	at example.sandbox$.main(example.sandbox.scala:5)
                                                  //| 	at example.sandbox.main(example.sandbox.scala)
     
}