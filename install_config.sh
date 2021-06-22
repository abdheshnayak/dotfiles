#!/bin/bash

# functions

show_intro(){
    cat << EOF
            ############################################
            #           Installing packages            #
            ############################################

            PACKAGES: bspwm sxhkd feh i3-gaps maim xclip
                    picom ttf-font-awesome rofi
                    base-devel git base-devel zsh dmenu
                    ranger htop

            #############################################
EOF
}

install_packages(){
    sudo pacman -S bspwm sxhkd feh i3-gaps maim xclip picom ttf-font-awesome rofi base-devel git base-devel zsh dmenu ranger htop
}

create_work_dir(){
    ([[ -d ~/abdhesh_lkjd ]] || [[ -L ~/abdhesh_lkjd ]]) && \
        sudo rm -r $dir
    mkdir ~/abdhesh_lkjd
}

setup_lf(){
    cat << EOF
            ############################################
                Installing lf Terminal File Manager
            ############################################
EOF

    git clone https://aur.archlinux.org/lf.git ~/abdhesh_lkjd/lf
    cd ~/abdhesh_lkjd/lf
    makepkg -si
}

setup_yay(){
    cat << EOF
            ############################################
                Installing yay package manager
            ############################################
EOF

    git clone https://aur.archlinux.org/yay.git ~/abdhesh_lkjd/yay
    cd ~/abdhesh_lkjd/yay
    makepkg -si
}

setup_xfsudo(){
    cat << EOF
            ############################################
                Installing xfsudo password prompt
            ############################################
EOF

    git clone https://aur.archlinux.org/xfsudo.git ~/abdhesh_lkjd/xfsudo
    cd ~/abdhesh_lkjd/xfsudo
    makepkg -si
}
# Tasks to be done

setup_xst_st(){
    cat << EOF
            ############################################
                Installing xst Terminal
            ############################################
EOF

    git clone https://aur.archlinux.org/xst-git.git ~/abdhesh_lkjd/xst-git
    cd ~/abdhesh_lkjd/xst-git
    makepkg -si

    cat << EOF
            ############################################
                Installing st Terminal
            ############################################
EOF

    git clone https://aur.archlinux.org/st-git.git ~/abdhesh_lkjd/st-git
    cd ~/abdhesh_lkjd/st-git
    makepkg -si

}

setup_polybar(){
    cat << EOF
            ############################################
                Installing Polybar
            ############################################
EOF
    git clone https://aur.archlinux.org/polybar.git ~/abdhesh_lkjd/polybar
    cd ~/abdhesh_lkjd/polybar
    makepkg -si
}

setup_powerlevezsh(){
    cat << EOF
            ############################################
                Installing powerlevel10k
            ############################################
EOF

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
    echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >>~/.config/zsh/.zshrc

}

dir=$(pwd)

show_intro
install_packages
create_work_dir
setup_lf
setup_yay
setup_xfsudo
setup_xst_st
setup_polybar
setup_powerlevezsh


sudo rm -r ~/abdhesh_lkjd

cat << EOF
            ############################################
                        Installation done
            ############################################
EOF

sudo rm -r "$dir/.git"

cd "$dir"

cat << EOF
            ############################################
                        Installing Configs
            ############################################
EOF

cd $dir

cp -r . ~/

cat << EOF
            ############################################
                        zsh Setup
            ############################################
EOF

chsh -s $(which zsh)

cd ~/

rm ~/install_config.sh

cat << EOF
            ############################################
                        Installation Done
            ############################################
EOF


sudo rm -r "$dir"

cd ~/
