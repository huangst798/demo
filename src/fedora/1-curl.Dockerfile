FROM --platform=$TARGETPLATFORM fedora

RUN dnf update -y && dnf install -y curl && dnf clean all
