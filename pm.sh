#! /bin/bash

function pm(){
    OS=$(lsb_release -is)
        if [[ "$1" == "-i" ]] || [[ "$1" == "--install" ]]; then
             if [[ "OS" == "Arch" ]] || [[ -z "$2" ]]; then
                rm /var/lib/pacman/db.lck
                pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
             elif [[ "OS" == "Arch" ]] || [[ -n "$2" ]]; then
                rm /var/lib/pacman/db.lck
                pacman -S $2
             elif [[ "OS" == "Ubuntu" ]] || [[ -z "$2" ]]; then
                 sudo apt-get install | fzf --multi --preview 'sudo apt-get install {1}' | xargs -ro sudo apt-get install
             elif [[ "OS" == "Ubuntu" ]] || [[ -n "$2" ]]; then
                 sudo apt-get install $2
        fi
        elif [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
            if [[ -z "$2" ]]; then
                rm /var/lib/pacman/db.lck
                pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Runs
            else
                rm /var/lib/pacman/db.lck
                pacman -Runs $2
            fi
        elif [[ "$1" == "-u" ]] || [[ "$1" == "--update" ]]; then
            rm /var/lib/pacman/db.lck
            pacman -Syu
        else
            echo "Option not defined."
        fi
    }
    alias pmi="pm -i"
    alias pmr="pm -r"
    alias pmu="pm -u"

