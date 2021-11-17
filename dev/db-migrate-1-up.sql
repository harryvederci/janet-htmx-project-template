create table if not exists todo_list (
  todo_list_id integer primary key autoincrement,
  todo_list_name text,
  todo_list_description text
);

--------------

create table if not exists todo_list_item (
  todo_list_item_id integer primary key autoincrement,
  todo_list_id integer references todo_list(todo_list_id),
  todo_list_item_text text,
  todo_list_item_checked number
);
