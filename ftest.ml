open Gfile
open Tools
open Ford


  (* à executer : 
    make
    ./ftest.native graph1.txt 0 0 graph1_RES.txt 
  *)




let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)     
  let graph = from_file infile in

  (* put the graph into Int graph*)
  let graph = gmap graph int_of_string in

  (*let graph = gmap graph (fun label -> label ^ "0") in*)

(*
  let resChemin = genererParcours graph source sink in
  let () = print_list resChemin in
  let flotMin = trouverMinimumFlots graph resChemin in
  print_int flotMin ;
  print_string "\n\n";
  let graph = calculerFlots graph resChemin flotMin in

  *)

  let graph = fordFulkerson graph source sink in
  
  (*let graph = add_arc graph 1 4 31 in
  Printf.printf("coucou\n%!");*)

  (* put the graph back into String graph again*)
  let graph = gmap graph string_of_int in

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  let () = export "graphiz_result.gv" graph in
  ()
