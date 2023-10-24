#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/.xprofile because that
# file is run automatically if someone uses a display manager (login screen)
# and so they are needed there. To prevent doubling up commands, I source them
# here with the line below.

# [ -f ~/.xprofile ] && . ~/.xprofile

# Your default LARBS WM is determined in your `~/.profile` on login.  Here we
# run the proper command to run when the graphical environment starts.


# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh


# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
[ -d $HOME/.local/share/keyrings ] || mkdir -p "$HOME"/.local/share/keyrings

# exect startxfce4


source ~/.zprofile

xset s 300 300
xset dpms 300 300 600

exec dbus-launch i3
#[[ $wm == "a" ]] && exec awesome
#[[ $wm != "a" ]] && exec dbus-launch i3

# exec gnome-session

