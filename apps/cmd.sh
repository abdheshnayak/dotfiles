#! /usr/bin/env zsh

stowIt() {
  stow --adopt -t $HOME $1
}

stowItOverride() {
  stow -t $HOME $1 
}

unstowIt() {
  stow -D -t $HOME $1
}

command=$1
[ ! -z $command ] && shift 1;

case $command in
  "install")
    stowIt $@
    ;;
  "install-all")
    for dir in $(command ls -d */ | xargs -0)
    do
      if [ "$dir" = "node/" ]; then
        [ -d $XDG_CONFIG_HOME/npm ] || cp -r node/npmrc $XDG_CONFIG_HOME/npm/npmrc
      else
        stowIt $dir
      fi
    done
    ;;
  "uninstall")
    unstowIt $@
    ;;
  "uninstall-all")
    for dir in $(command ls -d */ | xargs -0)
    do
      [ $dir != "node/" ] && unstowIt $dir
    done
    ;;
  *)
    echo "Usage: $0 {install|install-all|uninstall|uninstall-all}"
    exit 1
    ;;
esac

