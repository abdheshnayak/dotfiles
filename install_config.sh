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
    sudo pacman -S bspwm sxhkd feh i3-gaps maim xclip picom ttf-font-awesome rofi base-devel git zsh dmenu ranger htop yay ttf-indic-otf
}


create_work_dir(){
    ([[ -d ~/abdhesh_lkjd ]] || [[ -L ~/abdhesh_lkjd ]]) && \
        sudo rm -r $dir
    mkdir ~/abdhesh_lkjd
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

install_aur_packages(){
    yay -S lf xfsudo xst-git st-git polybar
}


# Tasks to be done



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
setup_yay
install_aur_packages
# setup_lf
# setup_xfsudo
# setup_xst_st
# setup_polybar
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

ln -s ~/.profile ~/.zprofile

cd ~/
