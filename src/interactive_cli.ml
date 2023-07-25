(* src/interactive_cli.ml *)

open Todo
open User_input

let rec run_interactive_cli (list : todo_list) (id_counter : int) : unit =
  Printf.printf "\nTo-Do Manager\n";
  print_todo_list list;
  Printf.printf "Menu:\n";
  Printf.printf "1. Add Task\n";
  Printf.printf "2. Remove Task\n";
  Printf.printf "3. Update Task\n";
  Printf.printf "4. Exit\n";

  match get_int_input () with
  | 1 ->
      let new_task = create_task_from_input id_counter in
      let updated_list = Todo.add_task list new_task in
      run_interactive_cli updated_list (id_counter + 1)
  | 2 ->
      Printf.printf "Enter the ID of the task to remove: ";
      let task_id = get_int_input () in
      let updated_list = Todo.remove_task list task_id in
      run_interactive_cli updated_list id_counter
  | 3 ->
      Printf.printf "Enter the ID of the task to update: ";
      let task_id = get_int_input () in
      (match Todo.find_task_by_id list task_id with
      | Some task ->
          let updated_task = create_task_from_input task_id in
          let updated_list = Todo.update_task list task_id updated_task in
          run_interactive_cli updated_list id_counter
      | None ->
          Printf.printf "Error: Task with ID %d not found.\n" task_id;
          run_interactive_cli list id_counter)
  | 4 -> ()
  | _ ->
      Printf.printf "Invalid choice. Try again.\n";
      run_interactive_cli list id_counter
