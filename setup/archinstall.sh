iwctl
station w<tab> connect <tab> <enter>
exit
ping archlinux.org

# Console fonts are located in /usr/share/kbd/consolefonts/setfont ter-132b
localectl set-keymap br-abnt2
timedatectl set-ntp true
lsblk
cfdisk /dev/sda # label: choose DOS, unless drive has > 2TB then choose GPT
# rezise2fs /dev/sda2 # in case need to expand to fit the rest of free mem on partition 
# pacman -Ss xf86-video, search anbd donwload one, serach about this on the wiki
#@grub problems https://askubuntu.com/questions/883992/stuck-at-grub-command-line
# Make the boot patition 128M as primary, if using grub, 512M is enough for everyone
# press B to set the boot flag, meaning this partition is bootable
# Give whatever else to the rest probably on /dev/sda2
# [Write] this changes
mkfs.ext4 /dev/sda1 # the boot partition
mkfs.ext4 /dev/sda2 # the rest
pacstrap /mnt base base-devel linux linux-firmware vim git networkmanager dialog iwd 
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
timedatectl list-timezones
timedatectl set-timezone Europe/Paris
pacman -S grub networkmanager efibootmgr
ls /sys/firmware/efi # if found than UEFI is enabled
systemctl enable NetworkManager
grub-install /dev/sda
grub-install --target=x87_64-efi --efi-directory=/boot --bootloader-id=grub /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
passwd
vim /etc/locale.gen
# uncoment pt_BR.UTF8 and pt_BR.ISO*
locale-gen

vim /etc/locale.conf
echo LANG=en-US.UTF8 > /etc/locale.conf
# LANG=pt-BR.UTF8
vim /etc/hostname
# Choose one of the below
ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
ln -sf /usr/share/zoneinfo/America/Maceio /etc/localtime
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
exit
cd / && umount -R /mnt/
reboot
sudo rmmod pcspkr
pacman-key --init && pacman-key --populate archlinux
pacman -Syy
pacman -Sy archlinux-keyring && pacman -Su
useradd -mG wheel excyber
passwd excyber
vim /etc/sudoers
# find %wheel
# @epicdoik
# há 1 ano (editado)
# New linux user here, and this was my experience following this tutorial: 
#
# The tutorial was insanely smooth and easy to follow. Ever thing went as planned until I realised that grub-install wasn't working. Panicking, I restarted my entire install from the start and encountered the same issue.
#
# If you encounter this problem, there's no need to restart. It's likely because your system is UEFI instead of EFI and that means in the step where you execute "mount /dev/sda1 /mnt/boot" you actually need to mount to /mnt/boot/efi instead. Unmount it with "umount" , create a new working directory at /mnt/boot/efi with "mkdir", and then execute the mount, this time to the correct directory. After this, grub should install as intended and you can continue with the tutorial.
#
# The next issue I encountered was in the very next step when trying to create a config file for grub, where the console mentioned that linux and initrd images were found, but also issues a warning that "os-prober will not be executed to detect other bootable partitions" if you get this issue, what you need to do is change some of grub's default settings. This is done by executing "vim /etc/default/grub" and look for the setting "GRUB_DISABLE_OS_PROBER=false" which is probably commented out. You need to uncomment it (ie. enable os prober).
#
# After resolving those two issues, the rest of the install continued smoothly and i managed to arrive at the fabled ASCII Arch logo. Hope my experience helps anyone encountering the same issues.
#
# edit: Oh also, for the peeps using wifi, if wifi menu doesn't work, search how to use iwctl instead
