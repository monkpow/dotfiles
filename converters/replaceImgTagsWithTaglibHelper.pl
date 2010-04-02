#!/usr/bin/perl -w

my $FILE=$ARGV[0];
my $IMGSRC=$ARGV[1];
my $IMGKEY=$ARGV[2];

use Tie::File;
tie @array, 'Tie::File', $FILE or die "...";
for (@array) {
 s@<img(.*)$IMGSRC([^>]*)>@<orbitz:img key="$IMGKEY">@;
}
untie @array;            # all finished

