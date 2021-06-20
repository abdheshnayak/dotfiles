sudo pacman -S feh bspwm sxhkd maim xclip picom ttf-font-awesome rofi base-devel git


git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
sudo rm -r yay

git clone https://aur.archlinux.org/xst-git.git
cd xst-git
makepkg -si
cd ..
sudo rm -r xst-git

git clone https://aur.archlinux.org/st-git.git
cd st-git
makepkg -si
cd ..
sudo rm -r st-git

sudo rm -r .git

cp -r . ~/