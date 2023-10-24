source ~/.zshrc

# reset again what was set outside
export ZDOTDIR=${HOME}

PS1="(scratchpad)$PS1"

preexec() {
    i3-msg '[instance="^scratchpad$"]' move scratchpad
    tmux new-window

    precmd() {
            echo "=============================="
            echo "exited with $?"
            exec sleep 10m
    }
}

zshexit() {
    # user pressed ^D or window got killed, will not be executed when the
    # shell gets "killed" by the final exec in the regular workflow
    i3-msg '[instance="^scratchpad$"]' move scratchpad
    tmux new-window
}

TRAPHUP() {
    # when the window gets killed, just die
    zshexit() {}
}