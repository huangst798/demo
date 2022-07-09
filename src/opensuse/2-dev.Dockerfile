FROM --platform=$TARGETPLATFORM xcmd/base-opensuse-1-curl

RUN zypper install -y bash zsh mksh git openssh-clients && zypper clean -a
