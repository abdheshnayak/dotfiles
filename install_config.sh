# functions
setup_lf(){
    git clone https://aur.archlinux.org/lf.git ~/abdhesh_lkjd/lf
    cd ~/abdhesh_lkjd/lf
    makepkg -si
}

setup_yay(){
    git clone https://aur.archlinux.org/yay.git ~/abdhesh_lkjd/yay
    cd ~/abdhesh_lkjd/yay
    makepkg -si
}
# Tasks to be done
cat << EOF
            ############################################
            #    Script processes the following        #
            ############################################
            #            1. Install Packages           #
            #            2. i3 setup                   #
            #            3. bspwm setup                #
            #            4. zsh Setup                  # 
            #            5. rofi Setup                 #
            #            6. ranger Setup               #
            ############################################
EOF


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

$(sudo pacman -S bspwm sxhkd feh i3-gaps maim xclip picom ttf-font-awesome rofi base-devel git base-devel zsh dmenu ranger htop
) &&

dir = $(pwd)

$(mkdir ~/abdhesh_lkjd) &&


cat << EOF
############################################
    Installing lf Terminal File Manager    
############################################
EOF

setup_lf()

cat << EOF
############################################
    Installing yay package manager    
############################################
EOF

setup_yay()

cat << EOF
############################################
    Installing xfsudo password prompt    
############################################
EOF

git clone https://aur.archlinux.org/xfsudo.git ~/abdhesh_lkjd/xfsudo
cd ~/abdhesh_lkjd/xfsudo
makepkg -si

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

cat << EOF
############################################
    Installing Polybar    
############################################
EOF
git clone https://aur.archlinux.org/polybar.git ~/abdhesh_lkjd/polybar
cd ~/abdhesh_lkjd/polybar
makepkg -si

sudo rm -r ~/abdhesh_lkjd

cat << EOF
############################################
    Installation done    
############################################
EOF

sudo rm -r $dir/.git

cd $dir

cat << EOF
############################################
    Installing Configs    
############################################
EOF

cp -r $dir/. ~/

cat << EOF
############################################
    zsh Setup    
############################################
EOF

chsh -s $(which zsh)

cat << EOF
############################################
    Installing powerlevel10k    
############################################
EOF

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >>~/.config/zsh/.zshrc

cd ~/

rm ~/install_config.sh

cat << EOF
############################################
    Installation Done    
############################################
EOF
