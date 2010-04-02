for file in  *
do mv "$file" `echo "$file" | sed -e 's/[-: ]/_/g'`.aiff
done

#mv *.html output



