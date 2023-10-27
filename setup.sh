#!/bin/bash

# functions

create_work_dir(){
    ([[ -d ~/vision_lkjd ]] || [[ -L ~/vision_lkjd ]]) && \
        sudo rm -r $dir
    mkdir ~/vision_lkjd
}



setup_yay(){
    cat << EOF
            ############################################
                Installing yay package manager
            ############################################
EOF
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git ~/vision_lkjd/yay-bin
    cd ~/vision_lkjd/yay-bin || exit
    makepkg -si
}

install_aur_packages(){
    yay -S --needed abseil-cpp acl alsa-lib alsa-topology-conf alsa-ucm-conf aom archlinux-keyring argon2 attr audit autoconf automake aws-cli-v2 base base-devel bash binutils bison boost-libs bridge-utils brotli btop bzip2 c-ares ca-certificates ca-certificates-mozilla ca-certificates-utils cairo catatonit conmon containerd containers-common coreutils criu crun cryptsetup curl dav1d db db5.3 dbus debugedit default-cursors device-mapper diffutils dnssec-anchors docker docker-buildx e2fsprogs expat extract_url fakeroot ffmpeg file filesystem findutils flac flex fontconfig freeglut freetype2 fribidi fuse-common fuse2 fzf gawk gc gcc gcc-libs gdbm gdk-pixbuf2 gettext giflib git glib2 glibc gmp gnupg gnutls go go-task-bin goimpl-git gperftools gpgme gpm graphite grep groff gsm guile gzip harfbuzz helm hicolor-icon-theme hidapi highlight highway hwdata hwloc iana-etc icu imath iproute2 iptables iputils jack2 jansson jbigkit json-c k9s kbd keyutils kmod krb5 kubectl l-smash lame lcms2 ldns less libarchive libass libassuan libasyncns libavc1394 libbluray libbpf libbs2b libbsd libcap libcap-ng libdatrie libde265 libdeflate libdrm libedit libelf libevent libffi libgcrypt libglvnd libgpg-error libheif libice libidn2 libiec61883 libisl libjpeg-turbo libjxl libksba libldap libluv libmd libmnl libmodplug libmpc libnet libnetfilter_conntrack libnfnetlink libnftnl libnghttp2 libnl libnsl libogg libomxil-bellagio libopenmpt libp11-kit libpcap libpciaccess libpng libpsl libpulse libraw1394 librsvg libsamplerate libsasl libseccomp libsecret libslirp libsm libsndfile libsoxr libssh libssh2 libsysprof-capture libtasn1 libtermkey libthai libtheora libtiff libtirpc libtool libunistring libunwind libusb libutempter libuv libva libvdpau libverto libvorbis libvpx libvterm libwebp libx11 libxau libxcb libxcrypt libxcursor libxdamage libxdmcp libxext libxfixes libxft libxi libxml2 libxmu libxrandr libxrender libxshmfence libxt libxv libxxf86vm licenses linux-api-headers llvm-libs lm_sensors lua luajit lz4 lzo m4 make mesa mongosh mpfr mpg123 msgpack-c nano ncurses neofetch neovim neovim-nvim-treesitter netavark nettle nftables node-gyp nodejs nodejs-gitmoji-cli nodejs-nodemon nodejs-nopt npm npth ntfs-3g nvtop ocl-icd onevpl opencore-amr openexr openjpeg2 openmpi openpmix openresolv openssh openssl operator-sdk opus p11-kit pacman pacman-mirrorlist pam pambase pango patch pciutils pcre pcre2 perl perl-clone perl-convert-binhex perl-encode-locale perl-error perl-html-parser perl-html-tagset perl-http-date perl-http-message perl-io-html perl-io-stringy perl-lwp-mediatypes perl-mailtools perl-mime-tools perl-timedate perl-uri pinentry pixman pkgconf podman popt portaudio procps-ng protobuf protobuf-c psmisc python python-awscrt python-certifi python-cffi python-colorama python-cryptography python-dateutil python-distro python-docutils python-greenlet python-jmespath python-msgpack python-ply python-prompt_toolkit python-protobuf python-pycparser python-pygments python-pynvim python-ruamel-yaml python-ruamel.yaml.clib python-six python-urllib3 python-wcwidth ranger rav1e readline ripgrep run-parts runc sdl2 sed semver shadow shared-mime-info slirp4netns speex speexdsp sqlite srt starship stow stylua sudo svt-av1 systemd systemd-libs systemd-sysvcompat tar texinfo tmux tpm2-tss tree-sitter tzdata unibilium unzip upx util-linux util-linux-libs v4l-utils vid.stab vim vim-runtime vmaf vulkan-icd-loader wayland wget which wireguard-tools x264 x265 xcb-proto xclip xorg-xprop xorg-xrandr xorgproto xvidcore xz yajl yarn yay-bin zimg zlib zoxide zsh zsh-fast-syntax-highlighting zsh-syntax-highlighting zstd
}


dir=$(pwd)

create_work_dir
setup_yay
install_aur_packages

sudo rm -r ~/vision_lkjd

cat << EOF
            ############################################
                        Installation done
            ############################################
EOF

sudo rm -r "$dir/.git"

cd "$dir" || exit

cat << EOF
            ############################################
                        Installing Configs
            ############################################
EOF

# cd $dir/apps

./$dir/apps/cmd.sh install-all

# cp -r . ~/

cat << EOF
            ############################################
                        zsh Setup
            ############################################
EOF

chsh -s "$(which zsh)"

# cd ~/

# rm ~/install_config.sh

cat << EOF
            ############################################
                        Installation Done
            ############################################
EOF


sudo rm -r "$dir"

# ln -s ~/.profile ~/.zprofile

cd ~/ || exit
