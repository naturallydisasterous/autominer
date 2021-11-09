#!/bin/bash 
tmux new-session -d -n mining
tmux send-keys -t mining "cd $HOME
" 
tmux send-keys -t mining "./mine.sh
"
