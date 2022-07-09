
FROM --platform=$TARGETPLATFORM xcmd/base-gentoo-1-curl

RUN emerge --sync && emerge bash zsh git && emerge --clean
