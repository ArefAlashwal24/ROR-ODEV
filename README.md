# Rails API Blog – ROR ÖDEV

A minimal **Rails API** that meets the assignment:

- **Core (75 pts):** 3 models — `User`, `Post`, `Comment`
- **API-only (+25):** JSON endpoints, no views
- **EXTRA (+20):** `Tag` + `PostTag` (many-to-many tags on posts)

## Stack
Ruby 3.3 • Rails 8 (API) • PostgreSQL 16 • rack-cors

## Model relations
- User (1) — (N) Post  
- Post (1) — (N) Comment  
- User (1) — (N) Comment  
- **Extra:** Post (N) — (N) Tag via PostTag

## Setup (Windows)
```powershell
# in PowerShell
cd D:\ROR-ODEV\blog_api
bundle install
$env:PGUSER="postgres"; $env:PGPASSWORD="postgres"; $env:PGHOST="127.0.0.1"; $env:PGPORT="5432"
rails db:create db:migrate db:seed
rails s
API base: http://127.0.0.1:3000/api/v1

Endpoints
Users

GET /api/v1/users

GET /api/v1/users/:id

POST /api/v1/users { user: { name, email } }

PUT/PATCH/DELETE /api/v1/users/:id

Posts

GET /api/v1/posts (includes user)

GET /api/v1/posts/:id (includes user & comments)

POST /api/v1/posts { post: { title, body, user_id } }

PUT/PATCH/DELETE /api/v1/posts/:id

Comments

GET /api/v1/posts/:post_id/comments

POST /api/v1/posts/:post_id/comments { comment: { body, user_id } }

GET/PUT/PATCH/DELETE /api/v1/comments/:id

Tags (EXTRA)

GET/POST/GET/:id/PUT/PATCH/DELETE /api/v1/tags

POST /api/v1/posts/:id/tags/:tag_id # attach

DELETE /api/v1/posts/:id/tags/:tag_id # detach

Quick test commands (PowerShell)
powershell
Copy code
# list
curl.exe http://127.0.0.1:3000/api/v1/users
curl.exe http://127.0.0.1:3000/api/v1/posts

# create examples
curl.exe -X POST http://127.0.0.1:3000/api/v1/users -H "Content-Type: application/json" -d "{\"user\":{\"name\":\"Charlie\",\"email\":\"charlie@example.com\"}}"
curl.exe -X POST http://127.0.0.1:3000/api/v1/posts -H "Content-Type: application/json" -d "{\"post\":{\"title\":\"New Post\",\"body\":\"Hello API\",\"user_id\":1}}"
curl.exe -X POST http://127.0.0.1:3000/api/v1/posts/1/comments -H "Content-Type: application/json" -d "{\"comment\":{\"body\":\"Nice!\",\"user_id\":2}}"
Notes
VIPS warnings in the console are harmless.

If curl flags fail in PowerShell, use curl.exe or Invoke-RestMethod.

DB creds are read from env vars set above.

