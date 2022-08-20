#!/bin/bash
cd backend
bundle
rails db:drop db:create db:migrate
rails db:seed
secret=$(rails secret)
EDITOR='echo "jwt_secret: '"$secret"'" >> ' rails credentials:edit
rails s