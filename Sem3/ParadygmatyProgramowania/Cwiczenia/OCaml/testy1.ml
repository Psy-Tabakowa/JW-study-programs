


let rec splitListRev remain ys half1 half2 =
  match remain with
  | 0 -> (half1, half2)
  | _ -> if remain > xsLen/2
              then splitListRev (remain - 1) (List.tl ys) (List.hd ys :: half1) half2
          else splitListRev (remain - 1) (List.tl ys) half1 (List.hd ys :: half2)
  ;;

let splitList len ys =
  let split = splitListRev len ys [] [] in
  (List.rev(fst split), List.rev(snd split))
  ;;



(*Zadanie 5b*)
let rec mergesort pred xs =
  let xsLen = List.length xs in
  
  (*Merge lists and return reversed merged list*)
  let rec mergeListsRev l1 l2 acc =
      match (l1, l2) with
      | ([], []) -> acc
      | ([], _) -> mergeListsRev [] (List.tl l2) (List.hd l2 :: acc) (* If l1 is empty, add from l2*)
      | (_, []) -> mergeListsRev (List.tl l1) [] (List.hd l1 :: acc) (* If l2 is empty, add from l1*)
      | (hd1::tl1, hd2::tl2) -> if pred hd1 hd2 then mergeListsRev tl1 tl2 (hd2 :: hd1 :: acc)
                                  else mergeListsRev tl1 tl2 (hd1 :: hd2 :: acc)
      in
  
  let rec mergeLists l1 l2 =
      List.rev(mergeListsRev l1 l2 [])
      in
  
  match xs with
  | [] -> []
  | [elem] -> [elem]
  | _ -> {
      let split = splitList xsLen xs in
      mergeLists (mergesort pred (fst split)) (mergesort pred (snd split))
  }
  ;;





let rec splitList2 fstHalfSize ys =
    if fstHalfSize <= 0 then ([], ys)
    else
        let temp = splitList2 (fstHalfSize - 1) (List.tl ys) in
        ((List.hd ys) :: fst temp, snd temp)
    ;;


splitList2 3 [1; 2; 3; 4; 5; 6];;
splitList2 2 [1; 2; 3; 4; 5; 6];;
splitList2 5 [1; 2; 3; 4; 5];;
splitList2 0 [1; 2; 3; 4; 5];;

splitList2 1 [1; 2; 3; 4; 5; 6];;
splitList2 1 [1; 2; 3; 4; 5];;



let rec przedzial a b = if a > b then []
                        else b :: (przedzial a (b - 1))
    ;;


przedzial 1 5;;





(*
let rec breadthBT bt =
    let rec bfs result queue tree =
        match tree with
        | Empty -> if tl queue = [] then result
                    else bfs (result @ [List.hd queue]) List.tl tree
        | Node(val, n1, n2) -> 
            



let rec breadthBT bt =
    let rec bfs queue tree =
        match tree with
        | Empty -> if tl queue = [] then []
                    else queue
        | Node(val, n1, n2) ->
            bfs 
*)


type 'a graph = Graph of ('a -> 'a list);;

let breadthSearch (Graph succ) startNode =
    let rec search visited queue =
        match queue with
        | [] -> []
        | h::t -> if List.mem h visited then search visited t
                else h :: search (h :: visited) (t @ succ h)
        in
    search [] [startNode]
    ;;


let f2 x y = function z -> x::y;;
  
let f1 x y z = x y z;;

let f1 x = x 2 2;; 


let f2 x y z = x ( y ^ z );;
