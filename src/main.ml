(* src/main.ml *)

open Todo
open File_io
open Interactive_cli
open Config

let () =
  let todo_list = load_todo_list () in
  let id_counter =
    match List.map (fun task -> task.task_id) todo_list with
    | [] -> 1
    | ids -> List.fold_left max (List.hd ids) ids + 1
  in
  run_interactive_cli todo_list id_counter;
  save_todo_list todo_list
