-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
insert into todo_list
(
  todo_list__name,
  todo_list__description
)
values
(
  :todo_list__name,
  :todo_list__description
)
returning *
;
