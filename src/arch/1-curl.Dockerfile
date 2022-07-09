FROM --platform=$TARGETPLATFORM archlinux

RUN pacman -Syu --noconfirm curl && \
    rm -rf /var/cache/pacman/*