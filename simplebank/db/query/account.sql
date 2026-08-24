-- name: CreateAccount :one
INSERT INTO accounts (
-- id is auto-incremented and created_at is already set by default so dont need to include them in the insert statement
  owner, balance, currency
) VALUES (
-- 3 columns to insert, so we need 3 placeholders for the values
  $1, $2, $3
) RETURNING *;
-- RETURNING *; will return the newly created account with all its fields, including the auto-generated id and created_at timestamp.

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM accounts
ORDER BY id
-- Pagination: LIMIT and OFFSET are used to paginate the results, allowing us to fetch a specific number of accounts starting from a specific offset.
LIMIT $1
OFFSET $2;

-- name: UpdateAuthor :one
UPDATE accounts
  set balance = $2
WHERE id = $1
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM accounts
WHERE id = $1;