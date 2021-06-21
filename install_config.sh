sudo pacman -S sbpwm sxhkd feh i3-gaps maim xclip picom ttf-font-awesome rofi base-devel git base-devel zsh dmenu ranger htop

git clone https://aur.archlinux.org/lf.git
cd lf
makepkg -si
cd ..
sudo rm -r lf


git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
sudo rm -r yay

git clone https://aur.archlinux.org/xfsudo.git
cd xfsudo
makepkg -si
cd ..
sudo rm -r xfsudo

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

git clone https://aur.archlinux.org/polybar.git
cd polybar
makepkg -si
cd ..
sudo rm -r polybar-git

sudo rm -r .git

cp -r . ~/

chsh -s $(which zsh)