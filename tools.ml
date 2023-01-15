(* Yes, we have to repeat open Graph. *)
open Graph

let clone_nodes gr = n_fold gr new_node empty_graph

  (* Récupérer seulement les nodes
  => empty_graph rgr
  acu = 0
  tant que node_exists gr acu, alors new_node rgr acu
     *)
  (*
  -- V1 -- 
  let rec loop acu g rgr = match node_exists g acu with
    | false -> rgr
    | true -> loop (acu+1) g (new_node rgr acu)
  in
    loop 0 gr empty_graph
    *)
  (*
  -- V2 -- 

  let rec loop acu g rgr = 
    if node_exists g acu 
      then loop (acu+1) g (new_node rgr acu) 
  else rgr
  in
  loop 0 gr []
*)
(*
-- V3 --
n_fold gr (fun acuGr id -> new_node acuGr id) empty_graph
*)


(*Pour tous les noeuds, on map *)
let gmap gr f = 
	e_fold gr (
		fun newGraph id1 id2 label -> new_arc newGraph id1 id2 (f label)
	) (clone_nodes gr)

(*
val e_fold: 'a graph -> ('b -> id -> id -> 'a -> 'b) -> 'b -> 'b
*)



let add_arc g id1 id2 n = 
  match (find_arc g id1 id2) with
  | None -> new_arc g id1 id2 n
  | Some m -> new_arc g id1 id2 (m + n)





