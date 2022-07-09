FROM --platform=$TARGETPLATFORM opensuse/tumbleweed

RUN rpm --rebuilddb && zypper update -y && zypper install -y curl && zypper clean -a
