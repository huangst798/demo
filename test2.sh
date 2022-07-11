# Section: utils

# cd "$(dirname "${BASH_SOURCE[0]}")"
# cd ..

buildx()(
    CDP="${1:?Provide cd into path}"
    IMAGE="${2:?Provide image}"
    FILE="${3:?Provide Dockerfile}"

    cd "$CDP" || return

    # docker build \
    #     --no-cache \
    #     -f "$FILE" \
    #     -t "$IMAGE"

    if ! echo docker buildx build \
        --no-cache \
        --platform "${PLATFORM:-linux/arm,linux/arm64,linux/amd64}" \
        -f "$FILE" \
        -t "$IMAGE" . --push; then

        printf "%s\n" "Buildx fail. $IMAGE" >&2

        # TODO: findout which specific platform is not supported by the specific os release.
        # exit 1
        return 1
    fi
)

rename_pushx(){
    echo docker tag "${1:?Provide source image}" "${2:?Provide target image}"
    echo docker push "${2}"
    # TODO: Multiple Arch ?
}
# EndSection

# Section: alpine
main_alpine(){
    case "$op" in
        alpine)             main alpine-1-curl && main alpine-2-dev    ;;
        alpine-1-curl)      buildx src/alpine xcmd/base-alpine-1-curl  1-curl.Dockerfile   ;;
        alpine-2-dev)       buildx src/alpine xcmd/base-alpine-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

# Section: debian
main_debian(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        debian)             local i; for i in debian:11 debian:10 debian:9 debian:latest; do main_debian "$i"; done
                            # rename_pushx "xcmd/base-debian-1-curl:11" "xcmd/base-debian-1-curl"
                            ;;
        debian:9)           main_debian debian-1-curl:9      && main_debian debian-2-dev:9      ;;
        debian:10)          main_debian debian-1-curl:10     && main_debian debian-2-dev:10     ;;
        debian:11)          main_debian debian-1-curl:11     && main_debian debian-2-dev:11     ;;
        debian:latest)      main_debian debian-1-curl:latest && main_debian debian-2-dev:latest ;;
        debian-1-curl:*)    version="${op#*:}"
                            buildx src/debian "xcmd/base-debian-1-curl:$version"  "1-curl.$version.Dockerfile"   ;;
        debian-2-dev:*)     version="${op#*:}"
                            buildx src/debian "xcmd/base-debian-2-dev:$version"   "2-dev.$version.Dockerfile"    ;;
    esac
}
# EndSection

# Section: ubuntu
main_ubuntu(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        ubuntu)             local i; for i in ubuntu:22 ubuntu:20 ubuntu:18 ubuntu:latest; do main_ubuntu "$i"; done
                            # rename_pushx "xcmd/base-ubuntu-1-curl:22" "xcmd/base-ubuntu-1-curl"
                            ;;
        ubuntu:18)          main_ubuntu ubuntu-1-curl:18     && main_ubuntu ubuntu-2-dev:18     ;;
        ubuntu:20)          main_ubuntu ubuntu-1-curl:20     && main_ubuntu ubuntu-2-dev:20     ;;
        ubuntu:22)          main_ubuntu ubuntu-1-curl:22     && main_ubuntu ubuntu-2-dev:22     ;;
        ubuntu:latest)      main_ubuntu ubuntu-1-curl:latest && main_ubuntu ubuntu-2-dev:latest ;;
        ubuntu-1-curl:*)    version="${op#*:}"
                            buildx src/ubuntu "xcmd/base-ubuntu-1-curl:$version"  "1-curl.$version.Dockerfile"   ;;
        ubuntu-2-dev:*)     version="${op#*:}"
                            buildx src/ubuntu "xcmd/base-ubuntu-2-dev:$version"   "2-dev.$version.Dockerfile"    ;;
    esac
}
# EndSection

# Section: bash3 bash4 bash5
main_bash(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        bash)
            for i in 3 4 5 ; do
                main_bash "bash${i}-1-curl" && main_bash "bash${i}-2-dev"
            done
            ;;
        bash*-*-*)
            local version=${op#bash}
            buildx src/bash "xcmd/base-${op}" "${version}.Dockerfile"   ;;
    esac
}
# EndSection

# Section: centos
main_centos(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        centos)             main_centos centos-1-curl && main_centos centos-2-dev           ;;
        centos-1-curl)      PLATFORM=linux/arm64,linux/amd64 buildx src/centos xcmd/base-centos-1-curl  1-curl.Dockerfile   ;;
        centos-2-dev)       PLATFORM=linux/arm64,linux/amd64 buildx src/centos xcmd/base-centos-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

# Section: arch
main_arch(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        arch)               main_arch arch-1-curl && main_arch arch-2-dev           ;;
        arch-1-curl)        PLATFORM=linux/amd64 buildx src/arch xcmd/base-archlinux-1-curl  1-curl.Dockerfile   ;;
        arch-2-dev)         PLATFORM=linux/amd64 buildx src/arch xcmd/base-archlinux-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

# Section: fedora
main_fedora(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        fedora)             main_fedora fedora-1-curl && main_fedora fedora-2-dev ;;
        fedora-1-curl)      PLATFORM=linux/amd64 buildx src/fedora xcmd/base-fedora-1-curl  1-curl.Dockerfile   ;;
        fedora-2-dev)       PLATFORM=linux/amd64 buildx src/fedora xcmd/base-fedora-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

# Section: gentoo
main_gentoo(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        gentoo)             main_gentoo gentoo-1-curl && main_gentoo gentoo-2-dev          ;;
        gentoo-1-curl)      buildx src/gentoo xcmd/base-gentoo-1-curl  1-curl.Dockerfile   ;;
        gentoo-2-dev)       buildx src/gentoo xcmd/base-gentoo-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

# Section: opensuse
main_opensuse(){
    local op="${1:?Provide image name}"; shift
    case "$op" in
        opensuse)           main_opensuse opensuse-1-curl && main_opensuse opensuse-2-dev      ;;
        opensuse-1-curl)    buildx src/opensuse xcmd/base-opensuse-1-curl  1-curl.Dockerfile   ;;
        opensuse-2-dev)     buildx src/opensuse xcmd/base-opensuse-2-dev   2-dev.Dockerfile    ;;
    esac
}
# EndSection

main(){
    while [ "$#" -gt 0 ]; do
        op="$1";    shift
        case "$op" in
            alpine*)        main_alpine     "$op" "$@" ;;
            bash*)          main_bash       "$op" "$@" ;;
            debian*)        main_debian     "$op" "$@" ;;
            ubuntu*)        main_ubuntu     "$op" "$@" ;;
            centos*)        main_centos     "$op" "$@" ;;
            arch*)          main_arch       "$op" "$@" ;;
            fedora*)        main_fedora     "$op" "$@" ;;
            gentoo*)        main_gentoo     "$op" "$@" ;;
            opensuse*)      main_opensuse   "$op" "$@" ;;
            all|*)          main alpine && main debian && main ubuntu && main centos
        esac
    done
}

# main all
# main "$@"

for sys in alpine ubuntu centos ; do 
    for dfile in $(ls ./src/$sys); do
        echo ./src/$sys/$dfile
    done 
done
FILE=`ls ./src/vscode/`
echo ${FILE}
for file in `ls ./src/*`
do
    image="image"
done
echo ${file} ${FILE}
if [ ${file} = ${FILE} ]
then
echo ${file}
fi
