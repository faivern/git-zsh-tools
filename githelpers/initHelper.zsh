#!/usr/bin/env zsh
# Create and initialize a new git repo
gnew() {
    if [[ -z "$1" ]]; then
        echo "Usage: gnew <project-name>"
        return 1
    fi

    mkdir -p "$1"
    cd "$1" || return 1

    git init -b main
    echo "# $1" > README.md
    git add README.md
    git commit -m "chore: initial commit"

    echo "Repository '$1' created and initialized on branch 'main'."

    # Optional: remote setup
    read -r "add_remote?Add GitHub remote (e.g., https://github.com/user/$1.git)? [y/N]: "
    if [[ "$add_remote" =~ ^[Yy]$ ]]; then
        read -r "remote_url?Remote URL: "
        git remote add origin "$remote_url"
        echo "Remote added: $remote_url"
  fi
}