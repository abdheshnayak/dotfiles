cd &

pacstrap -i /mnt base linux linux-firmware sudo nano &

genfstab -U -p /mnt >> /mnt/etc/fstab &

arch-chroot /mnnt /bin/bash &

cd &

pacman -S grub networkmanager gdm xfce4-terminal git &
systemctl enable gdm &
systemctl enable NetworkManager

