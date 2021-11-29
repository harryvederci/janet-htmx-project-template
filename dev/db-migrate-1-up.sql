create table if not exists todo_list (
  todo_list__id integer primary key autoincrement,
  todo_list__name text,
  todo_list__description text
) strict ;

--------------

create table if not exists todo_list_item (
  todo_list_item__id integer primary key autoincrement,
  todo_list__id integer references todo_list(todo_list__id),
  todo_list_item__text text,
  todo_list_item__checked integer
) strict ;

--------------

create table if not exists user (
  user__id integer primary key autoincrement,
  user__email_address text unique not null,
  user__password text not null,
  user__auth_token text -- Not 100% sure if storing the auth token in the DB is the way to go. I'd still need to verify it's correct on each request.
) strict ;
