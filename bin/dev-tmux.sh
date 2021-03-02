#!/bin/sh

# https://stackoverflow.com/questions/5609192/how-to-set-up-tmux-so-that-it-starts-up-with-specified-windows-opened
tmux new-session \; split-window -h -p 20 \;
