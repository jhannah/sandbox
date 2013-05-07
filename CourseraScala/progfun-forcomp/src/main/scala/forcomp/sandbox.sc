package forcomp

import common._

object sandbox {
  type Word = String
  type Sentence = List[Word]
  type Occurrences = List[(Char, Int)]
  val dictionary: List[Word] = loadDictionary     //> dictionary  : List[forcomp.sandbox.Word] = List(Aarhus, Aaron, Ababa, aback,
                                                  //|  abaft, abandon, abandoned, abandoning, abandonment, abandons, abase, abased
                                                  //| , abasement, abasements, abases, abash, abashed, abashes, abashing, abasing,
                                                  //|  abate, abated, abatement, abatements, abater, abates, abating, Abba, abbe, 
                                                  //| abbey, abbeys, abbot, abbots, Abbott, abbreviate, abbreviated, abbreviates, 
                                                  //| abbreviating, abbreviation, abbreviations, Abby, abdomen, abdomens, abdomina
                                                  //| l, abduct, abducted, abduction, abductions, abductor, abductors, abducts, Ab
                                                  //| e, abed, Abel, Abelian, Abelson, Aberdeen, Abernathy, aberrant, aberration, 
                                                  //| aberrations, abet, abets, abetted, abetter, abetting, abeyance, abhor, abhor
                                                  //| red, abhorrent, abhorrer, abhorring, abhors, abide, abided, abides, abiding,
                                                  //|  Abidjan, Abigail, Abilene, abilities, ability, abject, abjection, abjection
                                                  //| s, abjectly, abjectness, abjure, abjured, abjures, abjuring, ablate, ablated
                                                  //| , ablates, ablating, abl
                                                  //| Output exceeds cutoff limit.
  
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
  dictionary.groupBy(x => wordOccurrences(x))     //> res3: scala.collection.immutable.Map[forcomp.sandbox.Occurrences,List[forcom
                                                  //| p.sandbox.Word]] = Map(List((e,1), (i,1), (l,1), (r,1), (t,2)) -> List(litte
                                                  //| r), List((a,1), (d,1), (e,1), (g,2), (l,1), (r,1)) -> List(gargled), List((a
                                                  //| ,1), (e,1), (h,1), (i,1), (k,1), (n,1), (s,3)) -> List(shakiness), List((e,2
                                                  //| ), (g,1), (n,1)) -> List(gene), List((a,2), (n,1), (t,1), (y,1)) -> List(Tan
                                                  //| ya), List((a,1), (d,1), (e,2), (h,1), (m,1), (n,2), (o,1), (s,3)) -> List(ha
                                                  //| ndsomeness), List((a,2), (c,1), (e,2), (k,1), (l,1), (m,1), (p,1), (r,1), (t
                                                  //| ,1)) -> List(marketplace), List((a,1), (i,1), (l,2), (s,1), (v,1)) -> List(v
                                                  //| illas), List((d,2), (e,1), (h,2), (n,1), (r,1), (t,1), (u,1)) -> List(hundre
                                                  //| dth), List((a,3), (b,1), (c,1), (h,1), (i,2), (l,1), (o,1), (p,2), (r,1), (t
                                                  //| ,1), (y,1)) -> List(approachability), List((d,1), (e,2), (l,1), (s,1), (t,2)
                                                  //| ) -> List(settled), List((a,1), (g,1), (i,3), (l,1), (n,2), (t,1), (z,1)) ->
                                                  //|  List(Latinizing), List(
                                                  //| Output exceeds cutoff limit.
  
}