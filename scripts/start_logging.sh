#!/usr/bin/env bash

# path to log file - global variable
FILE="$1"

ansifilter_installed() {
	type ansifilter >/dev/null 2>&1 || return 1
}

system_osx() {
	[ $(uname) == "Darwin" ]
}

pipe_pane() {
	tmux pipe-pane "exec cat - | stdbuf -o0 -e0 $filter | ~/.tmux/plugins/tmux-logging/scripts/prepend-datetime.sh >> $FILE"
}

start_pipe_pane() {
	if ansifilter_installed; then
		local filter="ansifilter";
	elif system_osx; then
		local filter="sed -E 's/(\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]||]0;[^]+|[[:space:]]+$)//g'"
	else
		local filter="sed -r -e 's/(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]|)//g'"
	fi
	pipe_pane
}

main() {
	start_pipe_pane
}
main
