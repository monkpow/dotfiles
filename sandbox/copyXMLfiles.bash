for f in `find . -name "*xml" | sed "s/\.xml//"`; do echo $f`echo _en_UK.xml`; echo $f#ge_DE.xml; echo $f#zh_CH.xml; done;
