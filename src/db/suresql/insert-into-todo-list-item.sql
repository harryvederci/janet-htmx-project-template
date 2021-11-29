-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
insert
  into todo_list_item
(
  todo_list__id,
  todo_list_item__text,
  todo_list_item__checked
)
values
(
  :todo_list__id,
  :todo_list_item__text,
  :todo_list_item__checked
)
returning *
;
