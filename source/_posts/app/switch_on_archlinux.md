1. pacman -S yuzu bluez bluez-utils joycond hid-nintendo-dkms dkms
2. echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0664", GROUP="plugdev"' > /etc/udev/rules.d/yuzu.rules
3. bluetooth.service
4. groupadd plugdev -U mxd
5. sudo aliyunpan-go cd /switch520\(11\)

