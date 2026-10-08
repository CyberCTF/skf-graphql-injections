#!/bin/sh
# Admin/admin logs in and /graphql answers.
set -e
H=http://web:5000
curl -fsS -D - -o /dev/null -d "username=admin&password=admin" "$H/login" | grep -qi "^set-cookie: X-Api-Key="
curl -fsS -H "Content-Type: application/json" -d '{"query":"{ allPosts { edges { node { title } } } }"}' "$H/graphql" | grep -q '"allPosts"'
