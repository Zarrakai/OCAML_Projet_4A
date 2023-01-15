(* Permits use of Ford-Fulkerson algorithm *)
open Graph

(* Applique l'algorithme de Ford-Fulkerson en entier *)
val fordFulkerson: int graph -> id -> id -> int graph

(* Génère le parcours *)
(* Garder en tête à la fin qu'il ne faut pas explorer un noeud déjà exploré 
    => ne pas boucler *)
val genererParcours: int graph -> id -> id -> Graph.id list

(* Trouve le minimum des flots du chemin *)
val trouverMinimumFlots: int graph -> Graph.id list -> int

(* Met à jour le graphe de flots *)
val calculerFlots: int graph -> Graph.id list -> int -> int graph




(* Afficher le chemin *)
val print_list: int list -> unit