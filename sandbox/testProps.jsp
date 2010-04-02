#!/bin/bash

FILE=~/c/app/pagedef/content/legal/testPops.jsp


echo '<%@ taglib uri="/orbitztaglib.tld" prefix="orbitz" %>' > $FILE
echo '<html><head><style>a{display:block; font-family:arial;}</style></head><body>' >> $FILE

cat popup.properties | grep "\.href" |  sed "s/\([^\.]*\)\..*/<orbitz:popup key=\"\1\">\1<\/orbitz:popup>/" >> $FILE
echo '</body></html>' >> $FILE
