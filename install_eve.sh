#!/bin/bash
cd /opt/unetlab/addons/qemu/
mkdir /opt/unetlab/addons/qemu/linux-ubuntu20
mkdir /opt/unetlab/addons/qemu/linux-centos8
mkdir /opt/unetlab/addons/qemu/winserver-2022
mkdir /opt/unetlab/addons/qemu/vyos-1.4
###
wget -O - https://s3.amazonaws.com/s3-us.vyos.io/rolling/current/vyos-1.4-rolling-202204100814-amd64.iso > vyos-1.4/cdrom.iso
wget -O - https://mirror.yandex.ru/ubuntu-releases/20.04/ubuntu-20.04.4-desktop-amd64.iso > linux-ubuntu20/cdrom.iso
wget -O - https://mirror.yandex.ru/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20220414-dvd1.iso > linux-centos8/cdrom.iso
wget -O - https://software-download.microsoft.com/download/sg/20348.1.210507-1500.fe_release_SERVER_EVAL_x64FRE_en-us.iso > winserver-2022/cdrom.iso
###
qemu-img create -f qcow2 vyos-1.4/virtioa.qcow2 5G
qemu-img create -f qcow2 linux-ubuntu20/virtioa.qcow2 15G
qemu-img create -f qcow2 linux-centos8/virtioa.qcow2 15G
qemu-img create -f qcow2 winserver-2022/virtioa.qcow2 20G
###
ifconfig pnet1 10.0.138.1/24
###
ifconfig pnet1
iptables -t nat -A POSTROUTING -s 10.0.138.0/24 -o pnet0 -j MASQUERADE
###
echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
sysctl -p
