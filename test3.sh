for sys in alpine; do 
        for file in $(ls ./src/$sys); do   
            FILE=$( echo ./src/$sys/$file )
            IMAGE=$( echo $file)
            echo $FILE
            echo $IMAGE       
    done 
done