-- name: CreateTransfer :one
INSERT INTO transfers (
-- id is auto-incremented and created_at is already set by default so dont need to include them in the insert statement
  from_account_id, to_account_id, amount
) VALUES (
-- 3 columns to insert, so we need 3 placeholders for the values
  $1, $2, $3
) RETURNING *;
-- RETURNING *; will return the newly created transfer with all its fields, including the auto-generated id and created_at timestamp.

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

-- name: ListTransfers :many
SELECT * FROM transfers
WHERE from_account_id = $1 OR to_account_id = $1
ORDER BY id
-- Pagination: LIMIT and OFFSET are used to paginate the results, allowing us to fetch a specific number of transfers starting from a specific offset.
LIMIT $2
OFFSET $3;