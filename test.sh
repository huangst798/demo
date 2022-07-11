for sys in alpine arch bash debian devc fedora gentoo opensuse ubuntu centos ; do
        for dfile in $(ls ./src/$sys); do
        IMAGE==sys
            echo ./src/$sys/$dfile ${IMAGE}
    done 
done