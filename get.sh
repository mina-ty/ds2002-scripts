#!/bin/bash

echo "Get all my respositories in GitHub"

curl -s https://api.github.com/users/mina-ty/repos | jq -r .[].name
