#! /bin/bash

HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=5000000
SAVEHIST=1000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP



if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Luke's config for the Zoomer Shell

# autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
rangercd () {
    tmp="$(mktemp)-ranger"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        pushd $(cat "$tmp")
        dir="$(cat "$tmp")"
        rm -f "$tmp"
    fi
}


bindkey -s '^[o' 'rangercd\n'  # zsh
bindkey -s 'ø' 'rangercd\n'  # zsh
bindkey -s '^o' 'rangercd\n'  # zsh
bindkey -s '^p' 'code .\n'  # zsh
bindkey -s '^t' '$(tmux -2u a || tmux -2u)\n'



# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# powerlevel10k enable
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# fuzzy finder setup
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.config/zsh/fzf-keybindings.zsh ] && source ~/.config/zsh/fzf-keybindings.zsh

# Load zsh-syntax-highlighting; should be last.
source ~/.local/share/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 3>/dev/null

export GITLAB_NPM_REGISTRY_READ_TOKEN=o2zaEuTBkM4ZsMmeTS1C

export LANG=en_US.UTF-8


function xg {
  DRI_PRIME=1 $@
}

# source ~/workplace/plaxonic/.zsh/.zshrc 
source ~/.zprofile

eval "$(zoxide init zsh)"
