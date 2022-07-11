for IMAGE in ubuntu; do 
    for file in $(ls ./src/$IMAGE); do      
        FILE=$( echo ./src/$IMAGE/$file )
        echo $FILE
         
    done 
done