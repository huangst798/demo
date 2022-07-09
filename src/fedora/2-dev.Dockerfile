
FROM --platform=$TARGETPLATFORM xcmd/base-fedora-1-curl

RUN dnf install -y bash zsh mksh git openssh-clients && dnf clean all
