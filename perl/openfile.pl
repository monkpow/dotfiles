#!/usr/bin/perl
use warnings;

open (LOGFILE, "test.txt") or die "I couldn't open text.txt";
$title = <LOGFILE>;
print "Report Title: $title";
for $line (<LOGFILE>) {
 print $line;
}
close LOGFILE;




