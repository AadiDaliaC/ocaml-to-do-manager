(* src/user_input.ml *)

open Todo

let get_int_input () : int =
  try
    int_of_string (read_line ())
  with
  | Failure _ -> get_int_input ()

let get_string_input () : string =
  read_line ()

let create_task_from_input (id_counter : int) : task =
  Printf.printf "Enter task title: ";
  let title = get_string_input () in
  Printf.printf "Enter task description: ";
  let description = get_string_input () in
  { task_id = id_counter; task_title = title; task_description = description }

let rec process_user_action (list : todo_list) (id_counter : int) : todo_list =
  Printf.printf "\nChoose an action:\n";
  Printf.printf "1. Add Task\n";
  Printf.printf "2. Remove Task\n";
  Printf.printf "3. Update Task\n";
  Printf.printf "4. Exit\n";

  match get_int_input () with
  | 1 ->
      let new_task = create_task_from_input id_counter in
      let updated_list = Todo.add_task list new_task in
      process_user_action updated_list (id_counter + 1)
  | 2 ->
      Printf.printf "Enter the ID of the task to remove: ";
      let task_id = get_int_input () in
      let updated_list = Todo.remove_task list task_id in
      process_user_action updated_list id_counter
  | 3 ->
      Printf.printf "Enter the ID of the task to update: ";
      let task_id = get_int_input () in
      (match Todo.find_task_by_id list task_id with
      | Some task ->
          let updated_task = create_task_from_input task_id in
          let updated_list = Todo.update_task list task_id updated_task in
          process_user_action updated_list id_counter
      | None ->
          Printf.printf "Error: Task with ID %d not found.\n" task_id;
          process_user_action list id_counter)
  | 4 -> list
  | _ ->
      Printf.printf "Invalid choice. Try again.\n";
      process_user_action list id_counter
