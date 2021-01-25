// Jan Wielgus



class DuplicatedKey(msg: String) extends Exception(msg)

class Dictionary[K, V] private (private val rep: List[(K, V)])(implicit ev: K => Ordered[K]){

    def lookup(key: K): Option[V] = {
        @scala.annotation.tailrec
        def lookupRec(xs: List[(K, V)], key: K): Option[V] = {
            if (xs == Nil) None
            else {
                val (k, elem) :: tail = xs

                if (key < k) None
                else if (key == k) Some(elem)
                else lookupRec(tail, key)
            }
        }

        lookupRec(rep, key)
    }

    def insert(keyValue: (K,V)): Dictionary[K, V] = {
        def insertRec(xs: List[(K, V)], keyValue: (K,V)): List[(K, V)] = {
            val (key, elem) = keyValue
            if (xs == Nil) (key, elem) :: Nil
            else {
                val (k, x) :: tail = xs

                if (key < k) (key, elem) :: xs
                else if (key == k) throw new DuplicatedKey(s"Key $key is duplicated.")
                else (k, x) :: insertRec(tail, (key, elem))
            }
        }

        new Dictionary[K, V] (insertRec(rep, keyValue)) (ev)
    }

    def delete(key: K): Dictionary[K, V] = {
        def deleteRec(xs: List[(K, V)], key: K): List[(K, V)] = {
            if (xs == Nil) Nil
            else {
                val (k, x) :: tail = xs

                if (key < k) xs
                else if (key == k) tail
                else (k, x) :: deleteRec(tail, key)
            }
        }

        new Dictionary[K, V] (deleteRec(rep, key)) (ev)
    }

    override def toString: String = {
        rep.map(keyVal => s"${keyVal._1} -> ${keyVal._2}")
            .foldLeft("")((acc, keyVal) => acc + keyVal + ", ")
    }
}

object Dictionary {
    def apply[K, V](elems: (K, V)*)(implicit ev: K => Ordered[K]): Dictionary[K, V] =
        new Dictionary[K, V](elems.toList)(ev)
}





object TestDict {
  //class Point( ... }

  def main(args: Array[String]): Unit = {
    val dict = Dictionary("pies"->"dog", "kot"->"cat", "slon"->"elephant", "ptak"->"bird")
    println(dict)
    println(dict.lookup("pies"))
    println(dict.lookup("papuga"))
    val dict1 = dict.insert("papuga"->"parrot")
    println(dict1)
    println(dict1.lookup("papuga"))
    println(dict1.delete("papuga"))

    //val points = Dictionary(new Point(1,1) -> "p11", new Point -> "p00")
    //println(points)
    //println(points.insert(new Point(0.5,0)-> "p0.5"))
  }
}

