# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vision/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/vision/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/vision/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/vision/.fzf/shell/key-bindings.zsh"
