(* src/todo.ml *)

type task = {
  task_id : int;
  task_title : string;
  task_description : string;
}

type todo_list = task list

let add_task (list : todo_list) (task : task) : todo_list =
  task :: list

let rec remove_task (list : todo_list) (task_id : int) : todo_list =
  match list with
  | [] -> []
  | task :: rest ->
      if task.task_id = task_id then
        rest
      else
        task :: remove_task rest task_id

let rec update_task (list : todo_list) (task_id : int) (new_task : task) : todo_list =
  match list with
  | [] -> []
  | task :: rest ->
      if task.task_id = task_id then
        new_task :: rest
      else
        task :: update_task rest task_id new_task

let rec find_task_by_id (list : todo_list) (task_id : int) : task option =
  match list with
  | [] -> None
  | task :: rest ->
      if task.task_id = task_id then
        Some task
      else
        find_task_by_id rest task_id
