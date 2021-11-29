-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
select
  todo_list_item__id,
  todo_list_item__text,
  todo_list_item__checked
from
  todo_list_item
where
  todo_list__id = :todo_list__id
;
