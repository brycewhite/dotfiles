#!/bin/bash

usage() {
    echo "Usage: $0 <action>"
    echo "Actions:"
    echo "  stow     - Link all dot files into the home directory."
    echo "  restow   - Restow all do files where the have already been linked."
    echo "  unstow   - Undo all links from the home directory."
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

action=$1

case $action in
    stow)
        for dir in $(find . -maxdepth 1 -type d ! -name '*.*' | sed 's|^\./||'); do
            stow --stow $dir
        done
        ;;
    restow)
        for dir in $(find . -maxdepth 1 -type d ! -name '*.*' | sed 's|^\./||'); do
          stow --restow $dir
        done
        ;;
    unstow)
        reversed=$(echo $name | rev)
        for dir in $(find . -maxdepth 1 -type d ! -name '*.*' | sed 's|^\./||'); do
          stow --delete $dir
        done
        ;;
    *)
        echo "Error: Invalid action. Please use 'stow', 'restow', or 'unstow'."
        usage
        ;;
esac
