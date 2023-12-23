FROM ubuntu:focal
MAINTAINER Khlebus

# Use Ru mirror for faster download of x86_64 packages
RUN sed -i -- 's/archive.ubuntu.com/ru.archive.ubuntu.com/g' /etc/apt/sources.list && sed -i -- 's/deb /deb \[arch=amd64,i386\] /g' /etc/apt/sources.list && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
# Generate locale.
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo nano build-essential git crossbuild-essential-armhf bison flex libssl-dev bc swig python3 python3-setuptools python3-pip

RUN pip3 install binary-manager==0.0.6

# Add normal user homeuser. Change to any name you like. Also grant this user "sudo" right and don't require password to execute sudo.
#RUN adduser --quiet --disabled-password homeuser && echo "homeuser:123456" | chpasswd && adduser homeuser sudo && echo "homeuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/homeuser
#USER homeuser

#RUN git clone --depth 1 https://github.com/u-boot/u-boot.git /home/homeuser/u-boot
#WORKDIR /home/homeuser/u-boot/

#RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- Mele_I7_defconfig
#RUN make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
