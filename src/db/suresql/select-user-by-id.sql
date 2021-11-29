-- name: this-is-a-mandatory-but-ignored-name-value-for-the-suresql-lib
select
  *
from
  user
where
  user__id = :user__id
;
