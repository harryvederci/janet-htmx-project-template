-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
select
  *
from
  todo_list
where
  todo_list__id = :todo_list__id
;
