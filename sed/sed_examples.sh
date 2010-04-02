#for file in `ls -R`
#do sed -f ~/bin/sed.sh $file > ~/tmp/bk.$file | mv ~/tmp/bk.$file $file
#do echo $file
#done


for file in  *
do mv "$file" `echo "$file" | sed -e 's/[-: ]/_/g'`.aiff
done

#mv *.html output



