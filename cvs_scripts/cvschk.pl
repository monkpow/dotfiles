#!/usr/bin/perl -w
#
# cvschk -- fast offline check for new files and modifications of files

# cvschk : A perl program which checks the status of the CVS controlled
#          files and gives an ASCII table sorted after the status of files.
#	   
#          If you have used CVS, then you know that it is hard to 
#          get a good overview the CVS-status of the files in you 
#          directories. Any new files? Any files changes? 
#          cvschk will help the programmer get the overview in the
#          situation, where we do not have access to the CVS repository.
#	   
#          Note that the program does only local checks of the files
#          If you have fast access to the CVS repositiory, then consider
#          the cvsstat-program - which additionally can tell if other
#          people have made newer versions of the files.
#
# The program requires Perl 5.004 (maybe previous versions also work).
#
# It is tuned to parse the output of cvs(1) version 1.9.
# Earlier and later versions may require modifications to the script.
#
# ** Note that the first line might be wrong depending **
# ** on the location of your perl program.             **
#
# Sample output:
# The directory ./mytempdir is not under CVS control
# 
# Changed files
# ---------------
# ./cvs2html
# ./cvschk
# ./cvsstat
# 
# New files
# ---------------
# ./.#cvschk
# ./XX
# ./cvs2html.ok
#  
# Deleted files
# ---------------
# (none)                                      

# Changelog:
#
# Ver   Date        Author                Changelog
# ---   ----------  --------------------  -------------------------------------
# 1.12  2002-01-04  Michael Kohne         Fixed a $foo=<> warning for 
#                                         5.004_01 with defined($foo=<>)
#                                         Added a --tabular|-t switch
#
# 1.11  2001-12-27  Michael Kohne         Added cvsignore functionality
#                                         Handling of 'dummy timestamp' 
#                                         Handling of 'Result of Merge'
#
# 1.10  2001-11-06  Michael Kohne	  Added -r and -l options
#
# 1.9   2001-08-03  Lars G. T. J�rgensen  Hack to allow special entry-line
#
# 1.8   2001-06-07  Peter Toft            Back to the same as 1.6
#                                         CVS is my friend
#
# 1.7   2001-06-04  Peter Toft            Peter was very tired and 
#                                         applied a wrong patch -
#                                         version 1.7 is crap
#
# 1.6   2000-12-17  Peter Toft            Better description added
#
# 1.5   2000-11-04  Peter Toft            URL of cvsstat changed
#
# 1.4   2000-09-20  Peter Toft            Must show deleted files also
#                                         as the default
#
# 1.3   2000-08-08  Ole Tange and         Initial version
#                   Peter Toft 
# ----  ----------  --------------------  -------------------------------------
#
# -----------------------------------------------------------------------------
#
# This program is protected by the GPL, and all modifications of
# general interest should be emailed to the maintainer (pto@sslug.dk).
#
# This program also uses code parts from cvsstat 
# (same homepage as cvschk)
#
# Copyright 2000,2001 by Peter Toft <pto@sslug.dk> and Ole Tange <ole@tange.dk>
#   as well as
#   Lars G. T. J�rgensen <larsj@diku.dk>
#
# The URL of the home page of cvschk is shown below.


use Time::Local;
use strict;
use Getopt::Long;

my $startdir = ".";

my $debug = 0;
my (%files,%filesok,%seen,%skip);


# Michael Kohne 12/16/01
#
# Simulation of .cvsignore as CVS does it...
#
# using .cvsignore handling makes cvschk take from 2 to 3 times
# longer to run over the same set of files.
# in my tests, disabling cvsignore altogether, cvschk takes .2 
# seconds on my working directory. Adding cvsignore,takes 
# .4 seconds. 
# Note that I do not use individual .cvsignore files - if there
# are a lot of them in your directory tree, it will add run time
#
# variables used for .cvsignore handling
my $initcvsignoreregex;# regex holding all startup cvsignore pattersn (no ())
my $cvsignoreregex;# one regex holding all current cvsignore patterns
my $disable_cvsignore=0;# set to 1 to disable cvsignore emulation
			# (available in case it's REALLY screwed up)
my $disable_ind_cvsignore=0;# set to 1 to disable finding .cvsignore files
			    # in each directory.
my $debug_cvsignore = 0; # For debugging .cvsignore problems

my %mon;
@mon{qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)}=
    0..11; # Perl months are 0 .. 11

my ($version)    = ('$Revision: 1.1.1.1 $ ' =~ /^\$\w+: (.*) \$ $/);
my $URL          = "http://cvs.sslug.dk/cvs2html";
my $version_line = "cvschk version $version (see $URL)\n";

my $opt_all;
my $restrict;
my $local;
my $tabular;

my $opt_restrict;

sub show_version {print $version_line}

sub die_version  {die $version_line}

sub die_usage {
    my $bundled = ($] > 5.00399
		   ? "can be bundled"
		   : "can't be bundled, because your Perl is too old");
    die <<END_OF_USAGE; # Help in the style of GNU `ls --help' or `make --help'
Usage: $0 [OPTION]... 
  Show the CVS status of FILEs (the current directory by default),
  traversing directories recursively and telling if new files exist
  in the repository.
Options:
  -a, --all         Show all statistics, including the names of files that
                    are up to date, used tags, ignored patterns and more
  -r, --restrict    Don't show the names of the unknown files
		     (useful if you have many temporary files)
  -t, --tabular     Show one file per line, each preceeded with a status word,
		     Sorted by filename.
  -l, --local       Don't descend into sub-directories
  -d, --debug       Debug info
  -h, --help        Show this help end exit immediately
  -V, --version     Show the version line and exit immediately
The one-letter options $bundled.
END_OF_USAGE
}

sub die_help {show_version; die_usage}

# Let `-ar' mean `-a -r' and require `--all' (or -a) instead of `-all'.
if ($] > 5.00399) { # This requires 5.004, so silently skip it for older Perls.
    eval {Getopt::Long::config("bundling")}; # avoid 5.003 compilation error
    warn $@ if $@; # For Perl 5.004+ we do want to see any compilation error
}


GetOptions( "all|a"      => \$opt_all,
            "tabular|t"  => \$tabular,
            "restrict|r" => \$restrict,
            "local|l"    => \$local,
	    "help|h"     => \&die_help,
	    "debug|d"    => \$debug,
	    "version|V"  => \&die_version,
	  ) or die_usage;

sub cvs_changed_in_dir($); #define prototype (for recursion)

# functions for .cvsignore handling

# converts a given filename pattern
# (of the sort that sh(1) takes) to
# a perl regex of similar meaning.
#
# It works by doing the following:
#
# change:
# . to \.
# $ to \$
# * to .*
# ? to .
# 
sub fpat_to_regex($)
{
  my $fexp;
  $fexp = shift;
  $fexp =~ s/\./\\\./g;#change . to \.
  $fexp =~ s/\$/\\\$/g;#change dollar sign to \dollar sign
  $fexp =~ s/\*/.*/g;# change * to .*
  $fexp =~ s/\?/./g; # change ? to .
  return $fexp;
}

# copy the input list to one single regex, 
# items seperated by | symbols. 
# return the regex string
sub do_regex_convert
{
  my $rx = "";
  my $first = 1;#true for first element only


  # convert each element of cvsignore into a regex    
  # this makes the patterns usable in perl
  my $cp;
  foreach $cp (@_) {
    if (not $first) { $rx = $rx . "|"; }
    if ($first) { $first = 0; }
    $rx = $rx . fpat_to_regex($cp);
  }

  return $rx;
}

# first parameter is a reference to the array
# to be loaded
# the rest of the parameters are just items
# that need to be loaded into the array.
# Note that if a ! is found, the list is 
# emptied, then further items are added.
# returns true if a ! was found
sub load_list_from_list
{
  my $arref = shift;# get reference to array from front
  my $item;
  my $ret=0;#false means no ! found
  
  chomp @_;#kill newlines
  foreach $item (@_) {
    $item =~ s/^\s*(.*?)\s*$/$1/;#kill leading/trailing whitespace
    if ($item) { # empty string is false
      push @$arref,$item;
    }
    if ($item eq "!") {
      @$arref = ();# '!' causes list to clear
      $ret = 1;# ! found
    }
  }
  
  return $ret;
}

# loads the given list with lines from the
# specified file. Note that if a '!' is found
# all prior patterns are removed from the list
# before the following patterns are loaded
# first param is the filename, 
# second param is a reference to an array
# that the data is to go into
# returns true if a ! was found
sub load_list_from_file
{
    my @inlist;
    my $fname = shift;#filename to read from
    #if (not -e $fname) { return; }
    my $arref = shift;#array to store into
    open CVSIGNORE,"$fname" or return;#file might not exist, that's OK
    @inlist = <CVSIGNORE>;
    close CVSIGNORE;
    return load_list_from_list($arref,@inlist);
}

# loads $cvsignoreregex from
# $initcvsignoreregex and the .cvsignore file 
# in the local directory
sub load_cvsignore
{
  if ($disable_ind_cvsignore) {return;}#don't look for local .cvsignore files
  if ($disable_cvsignore) {return;}#don't do anything

  my $dir = shift;
  my @cvsignore;

  # bang will be true if a ! was found. In such cases, I need
  # to not use the pre-exisitng regex list.
  my $bang = load_list_from_file("$dir/.cvsignore",\@cvsignore);
 
  # if we get a local cvsignore list, then...
  my $rx = do_regex_convert(@cvsignore);
  if ($rx) {
    $cvsignoreregex = "(";
    if (not $bang) {$cvsignoreregex = $cvsignoreregex . $initcvsignoreregex . "|";}
    $cvsignoreregex = $cvsignoreregex . $rx . ")";
  } else {
    if ($bang) {$cvsignoreregex = "";}
    else {$cvsignoreregex = "(" . $initcvsignoreregex . ")";}
  }

  if ($debug_cvsignore) {print $dir,":",$cvsignoreregex, "\n";}
}


# loads all of the cvsignore patterns that 
# can be loaded at script startup
sub load_initial_cvsignore()
{
    #load the default patterns
    # (taken from http://www.gnu.org/manual/cvs-1.9/html_node/cvs_141.html#IDX399)
    #
    # this gives you the patterns that cvs normally starts with
    my @initcvsignore;
    push @initcvsignore,("RCS");
    push @initcvsignore,("SCCS");
    push @initcvsignore,("CVS");
    push @initcvsignore,("CVS.adm");
    push @initcvsignore,("RCSLOG");
    push @initcvsignore,("cvslog.*");
    push @initcvsignore,("tags");
    push @initcvsignore,("TAGS");
    push @initcvsignore,(".make.state");
    push @initcvsignore,(".nse_depinfo");
    push @initcvsignore,("*~");
    push @initcvsignore,("\#*");
    push @initcvsignore,(".\#*");
    push @initcvsignore,("\,*"); 
    push @initcvsignore,("_\$\*");
    push @initcvsignore,("*\$");
    push @initcvsignore,("*.old");
    push @initcvsignore,("*.bak");
    push @initcvsignore,("*.BAK");
    push @initcvsignore,("*.orig");
    push @initcvsignore,("*.rej");
    push @initcvsignore,(".del-*");
    push @initcvsignore,("*.a");
    push @initcvsignore,("*.olb");
    push @initcvsignore,("*.o");
    push @initcvsignore,("*.obj");
    push @initcvsignore,("*.so");
    push @initcvsignore,("*.exe");
    push @initcvsignore,("*.Z");
    push @initcvsignore,("*.elc");
    push @initcvsignore,("*.ln");
    push @initcvsignore,("core");


    # now, load (in proper order!)
    # each of the possible cvsignore files

    # there are 4 possible .cvsignore files:
    
    # $CVSROOT/CVSROOT/cvsignore
    # ~/.cvsignore
    # $CVSIGNORE environment variable
    # .cvsignore in current directory

    # The first (CVSROOT/cvsignore) would require calling cvs, so
    # we won't do that one.
    # The last (.cvsignore in current directory) is done
    # for each directory. It's handled in the load_cvsignore routine.

    # ~/.cvsignore
    my @inlist;
    my $item;
    my $HOME=$ENV{"HOME"};
    if (not $HOME) {$HOME = ".";}
    load_list_from_file("$HOME/.cvsignore",\@initcvsignore);
    
    # $CVSIGNORE environment variable
    my $igstr = $ENV{"CVSIGNORE"}; # get env var
    if ($igstr) {
      my @iglist = split(/\s+/, $igstr); #if it exists, convert to list
      load_list_from_list(\@initcvsignore,@iglist);
    }
    
    # now that @initcvsignore is setup, 
    # turn it into a regex string
    $initcvsignoreregex = do_regex_convert(@initcvsignore);

    # now preset the cvsignore regex string to match
    # @initcvsignore. That way, if we aren't using local
    # cvsignore files, we do nothing.
    $cvsignoreregex = "(" . $initcvsignoreregex . ")";
}
# routine to see if the given name is in the cvsignore regex
# returns true if it is, false if it's not
sub ignore_file($)
{
  #allow user to disable the cvsignore stuff
  if ($disable_cvsignore) {return 0;}
  if (not $cvsignoreregex) {return 0;}# if regex is empty, nothing matches the regex
  my $filename = shift;
 
  if ($debug_cvsignore) {print "ignore_file:",$filename,"\n";}

  if ($filename =~ $cvsignoreregex) {
    if ($debug_cvsignore) {print $filename," matches\n";}
    return 1;
  }
  
  if ($debug_cvsignore) {print $filename," doesn't match\n";}
  return 0;
}

sub cvs_changed_in_dir($) {
  my $dir = shift;

  my ($line,$filename,$version,$mtime,$date,
      $dir_filename,$cvstime,@subdirs,
      @new_in_dir,$i);

  # Examine status of files in CVS/Entries
  if(not open(ENTRIES,"$dir/CVS/Entries")) {
      if ($tabular) {
          push @{$files{Unknown}}, $dir;
      }
      else {
          warn "The directory $dir is not under CVS control\n";
      }
  } else {
      load_cvsignore($dir);#load up proper cvsignore for given directory

      while(defined ($line=<ENTRIES>)) {
	  # Parse CVS/Entries-line
          $line=~m!^/(.*)/(.*)/(.*)/.*/! or do {
	      $debug and warn("Skipping entry-line $line"); 
	      next; 
	  };
	  ($filename,$version,$date) = ($1,$2,$3);
	  $dir_filename=$dir."/".$filename;
	  	  
	  # Mark this file as seen
	  $seen{$dir_filename}=1;
	  
	  # if not exists: Deleted
	  if(not -e $dir_filename) {
	      push @{$files{Deleted}}, $dir_filename; next;
	  }
	  # if dir: save name for recursion
	  -d $dir_filename and do { 
	      push @subdirs, $dir_filename; next; 
	  };
      
	  # modification time of $dir_filename
	  $mtime= (stat $dir_filename)[9];

       
          if($date eq "dummy timestamp") {
            # dummy timestamp means it's new to the repository.
            push @{$files{Changed}}, $dir_filename;
            if ($debug) {
		print "$dir_filename is changed\n";              
	    }
          }
          elsif($date eq "Result of merge") {
            # result of merge means it's changed, then updated.
            push @{$files{Changed}}, $dir_filename;
            if ($debug) {
		print "$dir_filename is changed\n";              
	    }
          }
	  elsif(not 
	      $date=~/... (...)\s+(\d+)\s+(\d+):(\d+):(\d+) (\d{4})/) 
	  {
	      #bogus entry in Entires
	      warn "Warning: $dir_filename -> '$date' ".
		  "not in ctime(3) format\n";
	  } else {
	      $cvstime=timegm($5,$4,$3,$2,$mon{$1},$6);
	      if($cvstime != $mtime) {
		  push @{$files{Changed}}, $dir_filename;
		  if ($debug) {
		      print "$dir_filename is changed\n";
		  }
	      } else {
		  push @{$files{Unchanged}}, $dir_filename;
		  if ($debug) {
		      print "$dir_filename is Unchanged\n";
		  }
	      }
	  }
      }
      close ENTRIES;
      
      # Locate any new files/dirs
      if(not opendir(D,$dir)) {
	  warn("Cannot open $dir");
	  @new_in_dir= ();
      } else { 
	  @skip{qw(. .. CVS)}=1..3; # Filenames that that we want to ignore
	  				#(note: these are exact filenames)
	  @new_in_dir= 
	      (grep { not $seen{$_} } # files we have not already processed
	       map { $dir."/".$_ }    # map from file to dir/file
	       grep { not ignore_file($_) } # ignore files in the cvsignore list
	       grep { not $skip{$_} } # skip files to be ignored
	       readdir(D));
	  closedir(D);
      }
      
      # Remember new files (actually non-directories)
      push @{$files{New}}, grep { not -d $_ } @new_in_dir;
      if ($debug) { print "@{$files{New}} are new in $dir\n"; }

      # Remember new subdirs
      push @subdirs, grep { -d $_ } @new_in_dir;
      
      # Recurse all subdirs
      if (not $local) {
	      for $i (@subdirs) {  cvs_changed_in_dir($i); } 
      }
  }
}

sub print_status()
{
    my $k;
    my %show_these_states = ("Changed" => 1);
    if(not $restrict) {
    	$show_these_states{"New"} = 1;
    	$show_these_states{"Deleted"} = 1;
    }

    if($opt_all) { $show_these_states{"Unchanged"} = 1; }

    if ($tabular) {
        my %allfiles;		# key: filesname, value: state
	my ($file, $state, $statefiles);

    	$show_these_states{"Unknown"} = 1;
	while (($state, $statefiles) = each %files) {
	    for my $f (@{$statefiles}) {
		$allfiles{$f} = $state;
	    }
        }
	for $file (sort keys %allfiles) {
	    $state = $allfiles{$file};
	    printf("%-10s %s\n", $state, $file) if $show_these_states{$state};
        }
    }
    else {
        print "\n";
    	for $k (keys %show_these_states) {
    	    if(not $files{$k} or not @{$files{$k}}) {
    		# no files
    		$files{$k}=["(none)"];
    	    }
    	    print("$k files\n",
    		  "---------------\n",
    		  map { "$_\n" } sort @{$files{$k}});
    	    print "\n";
    	}
    }
}

load_initial_cvsignore();
if ($debug_cvsignore) {print "initial regex:",$cvsignoreregex,"\n";}
cvs_changed_in_dir($startdir);
print_status();

