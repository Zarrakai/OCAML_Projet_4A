open Graph
open Tools
(* Générer parcours OK _ suite a faire *)

let genererParcours g src dest = 
  (* parcourir les noeuds en récursif 
     on parcourt un noeud, s'il est égal à la destination,
        alors on arrête et on renvoit le chemin = liste de noeuds
        - parcourir les noeuds de proche en proche en récursif

        - on récupère les arcs du noeud N
        - on parcourt la liste des arcs de N
        - si le noeud n'est pas dispo dans la liste des destinations, 
            on l'ajoute et on va dedans
            
        - passer en acu la liste des noeuds parcourus
        - renvoyer liste vide si jamais y'a plus de noeud disponible
        *)
		(* NOTE : Je n'ai pas encore pris en compte les valeurs des arcs *)
	let rec parcoursNoeuds noeudActuel acu = 
		if noeudActuel = dest then List.rev(noeudActuel::acu) 
		else parcoursArcs noeudActuel acu (out_arcs g noeudActuel)

	and parcoursArcs noeudActuel acu listeArcs = match listeArcs with
		| [] -> []
		| (idDestArc, label) :: rest -> 
			(* si le label est > 0 et que ce noeud n'existe pas dans la liste *)
			if label > 0 && List.mem idDestArc acu = false
				then 
					let resParcours = parcoursNoeuds idDestArc (noeudActuel :: acu) in
					if resParcours = []
						then parcoursArcs noeudActuel acu rest
					else
						resParcours
			else 
				parcoursArcs noeudActuel acu rest
			
	in 
		parcoursNoeuds src []
	;;
(*
			match out_arcs g noeudActuel with
			(* S'il n'y a pas d'arcs, 
					on retourne acu ssi le dernier noeud est la dest, 
					sinon on retourne l'acu d'avant en supprimant le dernier  *)
			| [] -> if f :: acu = dest then acu else List.rev(deletedE :: List.rev(acu))
			(* Sinon, on parcourt les noeuds src et on lance monParcours dessus *)
			| r :: res -> if idR::r = dest then acu else monParcours idR::r (acu @ idR)
			(*| res -> (
				let rec parcoursArcs = function
				| [] -> []
				| a :: rest -> monParcours idr::a (acu@idR); parcoursArcs rest
				*)
	)
*)

let trouverMinimumFlots g chemin = 
	(* 	On parcourt les noeuds n et n+1 du chemin
			on trouve minArcs, la valeur minimale des libellés des arcs du chemin
				=> pour chaque noeud on fait find_arc sur n et n+1
				=> SI libelle < acu ALORS acu = libelle
		*)
		let rec findMin acu cheminActuel = match cheminActuel with
		| [] -> Option.get acu
		| [last] -> Option.get acu
		| n :: m :: rest -> if find_arc g n m < acu 
												then findMin (find_arc g n m) (m :: rest)
												else findMin acu (m :: rest)
		in
		findMin (Some max_int) chemin
;;

let calculerFlots g chemin min = 
	(*  
			On parcourt les noeuds n et n+1 du chemin
			on fait add_arc n (n+1) minArcs
	*)
	let rec majArcs graphFinal cheminActuel = match cheminActuel with
	| [] -> graphFinal
	| [last] -> graphFinal
	| n :: m :: rest -> majArcs (add_arc graphFinal n m (min*(-1))) (m :: rest)
	in
	majArcs g chemin
;;



let rec print_list l = match l with
| [] -> print_string "\n"
| e::f -> print_int e; print_string " "; print_list f;; 


let fordFulkerson g src dest = 
	(* on boucle sur nos trois fonctions 
		 SI on arrive à genererParcours = []
		 		ALORS on arrête, on retourne le graph Final *)
	let rec boucleFord graphFinal = match genererParcours graphFinal src dest with
	| [] -> graphFinal
	| resChemin -> (
			let () = print_list resChemin in
			let flotMin = trouverMinimumFlots graphFinal resChemin in
			print_int flotMin ;
			let graph = calculerFlots graphFinal resChemin flotMin in
			print_string "\n\n";
			boucleFord graph)
	in
	boucleFord g
;;