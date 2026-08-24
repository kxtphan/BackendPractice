-- name: CreateEntry :one
INSERT INTO entries (
-- id is auto-incremented and created_at is already set by default so dont need to include them in the insert statement
  account_id, amount
) VALUES (
-- 2 columns to insert, so we need 2 placeholders for the values
  $1, $2
) RETURNING *;
-- RETURNING *; will return the newly created entry with all its fields, including the auto-generated id and created_at timestamp.

-- name: GetEntry :one
SELECT * FROM entries
WHERE id = $1 LIMIT 1;

-- name: ListEntries :many
SELECT * FROM entries
WHERE account_id = $1
ORDER BY id
-- Pagination: LIMIT and OFFSET are used to paginate the results, allowing us to fetch a specific number of entries starting from a specific offset.
LIMIT $2
OFFSET $3;