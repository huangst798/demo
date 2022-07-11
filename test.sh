for sys in alpine arch bash debian devc fedora gentoo opensuse ubuntu centos ; do
        for dfile in $(ls ./src/$sys); do
            echo ./src/$sys/$dfile
    done 
done