# this example removes spaces and appends .aiff to each filename in a directory



for file in  *
do mv "$file" `echo "$file" | sed -e 's/[-: ]/_/g'`.mov
done

#mv *.html output
