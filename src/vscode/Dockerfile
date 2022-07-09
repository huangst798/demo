FROM xcmd/base-alpine-2-dev
# FROM --platform=$TARGETPLATFORM xcmd/base-opensuse-1-curl

ADD bashrc /root/___x_cmd_bashrc
RUN cat ___x_cmd_bashrc | tee -a ~/.bashrc ~/.zshrc

ADD vscodelib /root/vscodelib
RUN . /root/vscodelib && download "$(get_latest_release)"
