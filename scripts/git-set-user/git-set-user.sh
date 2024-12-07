#!/bin/bash

# This is a file with the first line that is the username and the second that is the email
USERFILE="$HOME/.config/git-set-user/git-user.txt"

if [ -z "$1" ]; then
    echo "Error: No user provided. Use 'dev' or 'none'."
    exit 1
fi

case "$1" in
    dev)
        if [ ! -f "$USERFILE" ]; then
            echo "Error: Configuration file '$USERFILE' not found."
            exit 1
        fi

        username=$(sed -n '1p' "$USERFILE")
        email=$(sed -n '2p' "$USERFILE")

        if [ -z "$username" ] || [ -z "$email" ]; then
            echo "Error: Missing username or email in '$USERFILE'."
            exit 1
        fi

        git config user.name "$username"
        git config user.email "$email"
        echo "Git user set to dev."
        ;;
    none)
        git config user.name "."
        git config user.email "."
        echo "Git user set to none."
        ;;
    *)
        echo "Error: Invalid identity '$1'. Use 'dev' or 'none'."
        exit 1
        ;;
esac
