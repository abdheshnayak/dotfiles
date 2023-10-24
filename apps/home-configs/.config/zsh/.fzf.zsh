# Setup fzf
# ---------
FZFPATH=$HOME/.config/.fzf
if [[ ! "$PATH" == *$FZFPATH/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZFPATH/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZFPATH/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZFPATH/shell/key-bindings.zsh"
