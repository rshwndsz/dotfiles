#! /usr/bin/env zsh

tmux new-session -d ide
sleep 1
tmux send-keys 'cd ~/cp && nvim main.cpp' Enter
# sleep 5
tmux split-window -v -p 20
# sleep 5
# tmux send-keys C-a p
# tmux send-keys ':Goyo' Enter
# sleep 2
# tmux send-keys 'i'
# tmux send-keys 'compro' Enter
tmux attach-session

