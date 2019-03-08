#!/bin/bash

t () { # set $SHELL fish it if is bash, and attach tmux session if exists
        if not hash tmux 2>/dev/null; then
                echo tmux is not installed, please instsall it!
        fi

        if [ $(basename $SHELL) == "bash" ]; then
                if [ -f ~/anaconda3/bin/fish ]; then
                        export SHELL=~/anaconda3/bin/fish
                elif hash fish 2>/dev/null; then
                        export SHELL=$(which fish)
                fi
        fi

        if [ "$TERM" != "screen-256color" ] && [ "$TMUX" != "" ]; then
                tmux attach
        elif [ "$TERM" != "screen-256color" ] && [ "$TMUX" = "" ]; then
                tmux
        else
                echo Already inside a tmux session!
        fi
}

t