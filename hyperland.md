the perfect system with hyperland https://www.youtube.com/watch?v=wNL6eIoksd8&t=351s
# Building on Ubuntu 23.04
You have 2 options, use the script descrived bellow or follow the instrutions

> script in [this gist](https://gist.github.com/Vertecedoc4545/6e54487f07a1888b656b656c0cdd9764) if you want the source code

```bash
wget https://gist.githubusercontent.com/Vertecedoc4545/6e54487f07a1888b656b656c0cdd9764/raw/2c5e8ccb428fc331307e2f653cab88174c051310/build-ubuntu-23.sh
chmod +x build-ubuntu-23.sh
./build-ubuntu-23.sh
```

> Warning you will need to add the bellow config to your hyprland.conf file after installing hyprland either way. 
> If you detect a bug respect to xdg-portals reffer to the [issue in github](https://github.com/hyprwm/Hyprland/issues/2195) 

```plain
misc {
  suppress_portal_warnings = true
}
```

## ___INSTRUCTIONS___

### Nvidia building : [Here](https://gist.github.com/Vertecedoc4545/07a9624924ac3e03ff0ab2d5e3616955#file-nvidia-partching-hyprland-ubuntu-md)

### Dependencies:
Most of our dependencies are disponible in the official repos,
for speed is recomendable to use nala package manager intead of apt
> installing nala will keep apt

```bash
sudo apt-get install -y nala
sudo nala install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libpango1.0-dev xdg-desktop-portal-wlr hwdata-dev
```

or if you don't want to use nala apt replacement do:


```bash
sudo apt-get install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev xdg-desktop-portal-wlr hwdata-dev

```

but some dependencies that we requiere are a little older in the repos so we need to build them

### Building libs from source

first get all of our sources for building then extarct them

__Hyprland and containing folder__
```bash
mkdir HyprSource
cd HyprSource

## We get Source
wget https://github.com/hyprwm/Hyprland/releases/download/v0.24.1/source-v0.24.1.tar.gz
tar -xvf source-v0.24.1.tar.gz

```

```bash
wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.31/downloads/wayland-protocols-1.31.tar.xz
tar -xvJf wayland-protocols-1.31.tar.xz

wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz
tar -xzvJf wayland-1.22.0.tar.xz

wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.1.1/downloads/libdisplay-info-0.1.1.tar.xz
tar -xvJf libdisplay-info-0.1.1.tar.xz

```

now only get inside each one, we build and install directly


### build wayland 1.22.0

```bash
cd wayland-1.22.0
mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Ddocumentation=false &&
ninja
sudo ninja install

cd ../..
```

### bulild wayland protocols

```bash
cd wayland-protocols-1.31

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

```

### Lets build libdisplay-info

```bash
cd libdisplay-info-0.1.1/

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..
```

### Lets build Hyprland!!!
you will need to change the folder permisions due to the use of sudo, so in the future you can acces and modify the folder
```bash
chmod a+rw hyprland-source

cd hyprland-source/
```


modify **config.mk** and change PREFIX=/usr/local to PREFIX=/usr
or use this command

```bash 
sed -i 's/\/usr\/local/\/usr/g' config.mk
```

also in that file you could use your custom cflags as for example adding -O3 or -Ofast optimization even -Og etc..

### then only do:

```bash
sudo make install

```

***enjoy Hyprland !!**

