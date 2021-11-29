-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
update
  todo_list_item
set
  todo_list_item__text = :todo_list_item__text
where
  todo_list_item__id = :todo_list_item__id
returning
  *
;
