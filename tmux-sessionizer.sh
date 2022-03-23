#!/usr/bin/env bash


selected=$(find ~/workspaces/Logistiview ~/workspaces/tecnotree/d-stack/dclm -mindepth 1 -maxdepth 1 -type d | fzf)
if [[ -z $selected ]]; then
    exit 0
fi
selected_name_base=$(basename "$selected")
# selected_name_parent=$(basename -- $(dirname "$selected"))
# selected_name=$(echo "${selected_name_parent}>${selected_name_base}" | tr . _)
selected_name=$(echo "${selected_name_base}" | tr . _)

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
else ! tmux has-session -t $selected_name 2> /dev/null;
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t $selected_name
else
    tmux switch-client -t $selected_name
fi