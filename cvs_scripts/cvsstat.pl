#!/usr/bin/perl -w
#
# cvsstat : A perl program which transforms the 'cvs status' 
#           output to an ASCII table sorted after the status of files.
#
#           If you have used CVS, then you know that it is hard to 
#           get a good overview the CVS-status of the files in you 
#           directories. Any new files? Any files changes? Any files
#           which other people have changed in the repository?
#           cvsstat will help the programmer get the overview.
#           The program can be used for any type of CVS archive, 
#           local as well as remote.
#
#           Note that the program requires fast access to the 
#           repository! If this is not the case, then consider
#           the cvschk-program for fast off-line CVS status summary.
#
# The program requires Perl 5.004 or later (maybe previous versions also work).
#
# It is tuned to parse the output of cvs(1) version 1.9.
# Earlier and later versions may require modifications to the script.
#
# ** Note that the first line might be wrong depending **
# ** on the location of your perl program.             **

# Sample output:
#
#  1 file(s) locally modified
# =============================================================
#    mat2html
# =============================================================
#
#  2 file(s) are new to the local CVS
# =============================================================
#    TODO
#    Newfilegen
# =============================================================
#
# 4 file(s) are up to date
#
# cvsstat version 2.15 (see http://cvs.sslug.dk/cvs2html)
#

# Changelog
#
# Ver   Date        Author                Changelog
# ---   ----------  --------------------  -------------------------------------
# 2.19  2002-02-04  Peter Toft            Bug fix - list of unknown files
#                                         could under certain conditions 
#                                         look very odd.
#
# 2.18  2001-08-29  Ulrik Dickow          Quote path variables in regexps with
#                                         \Q..\E (bug found by Daniel Rueckert)
#
# 2.17  2001-06-30  Ole Tange             Hack to avoid cvstat -h report twice
#
# 2.16  2001-06-07  Henning Moll          Added support for reporting sticky
#                                         files.
#
# 2.15  2000-12-17  Peter Toft            Sort of changelog reversed
#                                         Added better description.
#
# 2.14  2000-11-04  Peter Toft            URL of cvsstat changed
#
# 2.13  2000-03-13  Paul Davey            Hack to get cvsstat working on NT4
#
# 2.12  1999-08-01  Ulrik Dickow          Fixed bugs: `./' removal, lost files,
#                                         non-CVS-dirs, don't ignore .foo-dirs,
#                                         initialize $cvsRegexWrappers.  Less
#                                         code bloat, mostly reading files.
#
# 2.11  1999-08-01  Stefan Eissing        Added support for individual 
#                                         repositories per subdir
#
# 2.10  1999-04-20  Ulrik Dickow          Made wrappers support work no worse
#                                         than before damage by cvsignore fix.
#                                         Cleaned up a bit (mostly list->hash).
#
# 2.9   1999-04-17  Ulrik Dickow          Updated --help and brought it closer
#                                         to GNU standards.  Fixed severely
#                                         broken .cvsignore support.
#
# 2.7   1998-12-30  Martin Vetter         Scan ~/.cvs{ignore,wrappers}
# 2.8                                     and CVSROOT/cvs{ignore,wrappers}
#                                         and ...../.cvsignore
#                                         for better handling of unknown
#                                         and wrapped files and directories.
#                                         Completed limited (?) support
#                                         for file/directory arguments.
#                                         Added "script" script generation
#                                         for automagical CVS update.
#                                         Added detection of bad directories.
#                                         Refined file classification.
#                                         Detection of file locks.
#                                         Listing of symbolic names / tags. 
#                                         Learned some more Perl programming...
#                                         Some code cleanups.
#                                         Window$ compatibility possibly
#                                         broken because of STDERR redirection.
#                                         Bad performance because of multiple
#                                         calls to "cvs status".
#
# 2.6   1998-11-02  Perry A. Stoll        Killed GNU find. Pure Perl now!
#
# 2.5   1998-09-22  Andrew Birkett        Bugfix to allow filenames to contain
#                                         spaces.
#
# 2.4   1998-05-31  Ulrik Dickow          Fixed 5.003 incompatibility (use %s
#                                         instead of %i).  Don't show 0 unknown
#                                         files.  Option bundling if 5.004+.
#                                         Better help.  Keep Larry Wall style
#                                         indentation; best edited w/ Emacs!
#
# 2.3   1998-05-31  Ulrik Dickow          Bug if file that "Needs Checkout" is
#                                         not lost (treat same as need patch).
#                                         This happens for branch-only files
#                                         that were modified by another user.
#                                         SSLUG URL+email have moved up in DNS.
#                   Peter Toft            Added the r/restrict option that 
#                                         drops the the unknown files. Useful  
#                                         if making a lot of temporary files.
#
# 2.2   1998-04-29  Ulrik Dickow          Fixed $version inconsistency.
#                                         (Re-)added (better) Revision parsing.
#
# 2.1   1998-04-28  Ulrik Dickow          Corrected e-mail & URL (now sslug).
#                                         Bug if lost files (new bug in 2.0).
#                                         Bug if `Entry Invalid'.
#                                         Added support for `Locally Removed'.
#                                         Use CVS/Repository to get consistent
#                                         paths printed (all relative to cwd);
#                                         also saves CVSROOT server headaches.
#                                         Bug if unresolved conflict.
#                                         Tell unrecognized statuses (@other).
#                                         Remove `Attic' from printed paths.
#                                         Bug if empty subdir (new in 2.0).
#
# 2.0   1998-04-27  Ulrik Dickow          Bug if sticky tags (xtra cvs output).
#                                         Bug if CVSROOT=":local:c:\winnt\dir".
#                                         Bug if \W chars (like `-') in paths.
#                                         Bug if `CVS' part of a dirname.
#                                         Bug if new files (due to `>& ...').
#                                         MAJOR rewrite, Perl 5 style instead
#                                         of C style (MUCH fewer lines).
#                                         Added GNU --help & --version options.
#                                         (ukd at kampsax dot dk)
#
# ----  ----------  --------------------  -------------------------------------
#
# Feature wishlist:
#   * Major cleanup/completion/rewrite of all the *cvs{ignore,wrappers} code
#     (and of excessive grep-map usage).
#     E.g. read directory-specific .cvswrappers too (like current .cvsignore).
#   * Easy way to show what happens when I hit "cvs update"
#   * Support for -I <ignore pattern> ... command line arguments
#   * Support for `cvs -nq update -d' to see new dirs in repository (added by
#     another user)?  (More flexible than `update -d' in ~/.cvsrc).
#
# -----------------------------------------------------------------------------
#
# This program is protected by the GPL, and all modifications of
# general interest should be emailed to the maintainer (pto@sslug.dk).
#
# Copyright 1997-2002 by Peter Toft <pto@sslug.dk> and the authors below
# Ole Tange <ole@tange.dk>
# Ulrik Dickow <ukd@kampsax.dk>
# Andrew Birkett <adb@tardis.ed.ac.uk>
# Perry A. Stoll <pas@xis.xerox.com>
# Martin Vetter <vetter@ilink.de>
# Paul Davey <pd@pdc.co.uk>
# The URL of the home page of cvsstat is shown below.

use strict;

use Getopt::Long;
use File::Find qw();
use File::Basename;
use IO::File;
use DirHandle;
use Cwd;
use IPC::Open3;

require 5.003;      # But 5.004_04 or newer is recommended

my ($version)    = ('$Revision: 1.1.1.1 $ ' =~ /^\$\w+: (.*) \$ $/);
my $URL          = "http://cvs.sslug.dk/cvs2html";
my $version_line = "cvsstat version $version (see $URL)\n";

sub show_version {print $version_line}

sub die_version  {die $version_line}

sub die_usage {
    my $bundled = ($] > 5.00399
		   ? "can be bundled"
		   : "can't be bundled, because your Perl is too old");
    $you::must_die=1;
    die <<END_OF_USAGE; # Help in the style of GNU `ls --help' or `make --help'
Usage: cvsstat [OPTION]... [FILE]...
  Show the CVS status of FILEs (the current directory by default),
  traversing directories recursively and telling if new files exist
  in the repository.
Options:
  -a, --all         Show all statistics, including the names of files that
		     are up to date, used tags, ignored patterns and more
  -r, --restrict    Don't show the names of the unknown files
		     (useful if you have many temporary files)
  -s, --script      Show script of needed cvs actions
  -v, --verbose     Show how we do things (useful for debugging)
  -h, --help        Show this help end exit immediately
  -V, --version     Show the version line and exit immediately
The one-letter options $bundled.
END_OF_USAGE
}

sub die_help {show_version; die_usage;}

# Let `-ar' mean `-a -r' and require `--all' (or -a) instead of `-all'.
if ($] > 5.00399) { # This requires 5.004, so silently skip it for older Perls.
    eval {Getopt::Long::config("bundling")}; # avoid 5.003 compilation error
    warn $@ if $@; # For Perl 5.004+ we do want to see any compilation error
}

my $debug_cvsignore = 0; # For debugging .cvsignore problems

my $show_all;
my $show_script;
my $restrict;
my $verbose;
my $err;

$err=GetOptions( "all|a"      => \$show_all,
	    "restrict|r" => \$restrict,
	    "help|h"     => \&die_help,
	    "script|s"   => \$show_script,
	    "verbose|v"  => \$verbose,
	    "version|V"  => \&die_version,
	  );
exit if $you::must_die;
$err or die_usage();

sub printf_header {
  my $dir = shift;
  my $changes = shift;

  if ($show_script) {
    if ($changes) {
      print "#! /bin/sh\n\n";
      print "# ------------------------------------------------------------\n";
      print "# cvsstat: $dir\n";
      print "# ------------------------------------------------------------\n";
      print "\ncd $dir\n\n";
    }
  } else {
    print "\ncvsstat: $dir\n\n";
  }
}

sub printf_footer {
  if (! $show_script) {
    show_version;
  }
}

sub printf_script {
  my $format = shift;
  my $action = shift;
  my @files = @_;
  return unless @files;
  
  print  "# ------------------------------------------------------------\n";
  printf "# " . $format . "\n", scalar @files;
  print  "# ------------------------------------------------------------\n";
  if ($action eq "add") {
    my %dirs;
    my ($base, $dir);
    foreach (@files) {
      $dir = dirname ($_);
      $dirs{$dir} .= basename ($_) . "@";
    }
    foreach $dir (keys %dirs) {
      chop $dirs{$dir};
      print "\n( cd $dir && \\\n  cvs add \\\n      \\\n      " . 
	join (" \\\n      ", split ("@", $dirs{$dir})) .
	  " \\\n)\n";
    }
    if ($format =~ /dir/) {
      $action = "";
    } else {
      $action = "commit";
    }
  }
  my $comment = "";
  if ($action ne "") {
    if ($action eq "add" || $action eq "commit") {
      $comment = "-m \"modifications automated by cvsstat\" ";
    }
    printf "\ncvs $action $comment\\\n    \\\n    " . 
      join (" \\\n    ", @files) . "\n\n";
  }
}

sub printf_scalar {
  my $format = shift;
  my @files = @_;
  return unless @files;

  if (! $show_script) {
    printf "\n " . $format . "\n", scalar @files if @files;
  }
}

sub printf_arr {
  my $format = shift;
  my @files = @_;
  return unless @files;
  
  if (! $show_script) {
    printf "\n " . $format . "\n", scalar @files;
    print "==============================================================\n";
    foreach (@files) {printf "   $_\n"}
    print "==============================================================\n";
  }
}

sub printf_arr2 {
  my $format = shift;
  my $action = shift;
  my @files = @_;
  if (! $show_script) {
    printf_arr $format . " - " . $action . " !", @files;
  } else {
    printf_script $format, $action, @files;
  }
}

sub runSilent {          # fix stderr redirection for WINDOWS COMPATIBILITY
  my $command    = shift;
  my $keepErrors = shift;
  $verbose && print "$command\n";
  if ($keepErrors) {
    $command .= " 2>&1";
  } else {
    $command .= ($^O eq "MSWin32" ? " 2> nul" : " 2> /dev/null");
  }
  return `$command`;
  # open SAVED_STDOUT, ">&STDOUT";
  # open SAVED_STDERR, ">&STDERR";
  # if ($keepErrors) {
  #   open STDERR, ">&STDOUT";
  # } else {
  #   open STDERR, "> /dev/null";
  # }
  # open COMMAND, "-|" or exec $command;
  # my @result = <COMMAND>; # `$command`;
  # print "RESULT: @result\n";
  # close STDOUT;
  # close STDERR;
  # open STDOUT, ">&SAVED_STDOUT";
  # open STDERR, ">&SAVED_STDERR";
  # close SAVED_STDOUT;
  # close SAVED_STDERR;
}

# some shells have length limitations. group arguments and quote.
# this lets commands work on huge CVS dirs even on windows
sub groupQuoted {
  my $shellCmdLength = 1024; # longest command we can send to shell
  # quote the filenames, in case they include spaces
  my @quoted = map {("\"" . $_ . "\" ")} @_;
  my @grouped = ();
  while (@quoted) {
    my $groupQuoted = "";
    while (length ($groupQuoted) < $shellCmdLength && @quoted) {
      $groupQuoted .= shift @quoted;
    }
    push @grouped, $groupQuoted;
  }
  return @grouped;
}

sub groupQuotedByDir {
  my @names = @_;
  my @groupedQuoted;
  my @namesGrouped;
  my $dirname = "";
  if (@names) {
    $dirname = dirname ($names[0]);
  }
  while (@names) {
    my $name = shift @names;
    my $dirnameNew;
    push @namesGrouped, $name;
    if (@names) {
      $dirnameNew = dirname ($names[0]);
    }
    if (! @names || $dirname ne $dirnameNew) {
      push @groupedQuoted, [ groupQuoted (@namesGrouped), $dirname ];
      @namesGrouped = ();
      $dirname = $dirnameNew;
    }
  }
  return @groupedQuoted;
}

sub read_lines {
    # Read first or all lines of given file, depending on context.
    # Used for reading Root and Repository files.
    my $file = shift;
    my $fh = new IO::File "< $file" or return undef; # Allow for non-CVS files
    return <$fh>; # First line in scalar context, otherwise array of lines
}

sub read_chomp_line {
    # Return first line of given file, except for possible final newline.
    my $file = shift;
    my $line = read_lines $file;
    chomp $line if defined $line;
    return $line;
}

# Where did we get which patterns for CVS ignore and CVS wrappers.
my @cvsSourceIgnore;
my @cvsSourceIgnoreLocal;
my @cvsSourceWrappers;
my @cvsPatIgnore;
my @cvsPatWrappers;
my $cvsRegexWrappers = "\777"; # Initialize to regexp that'll never match

sub readCvsConfigFile {
  my $cvsConfigFile = shift;
  if (-f $cvsConfigFile) {
    if (! -r $cvsConfigFile) {
      warn "Warning: Could not read $cvsConfigFile.\n";
    } else {
      return read_lines $cvsConfigFile;
    }
  }
  return ();
}

sub regexFromPatterns {
  my @patterns = @_;
  my $regex = "^\$";
  if (@patterns) {
    map {s/([\.\!\$])/\\$1/g ; s/([\*\?])/[^\/]$1/g} @patterns;
    $regex = "(^|\/)(" . join ("|", @patterns) . ")\$";
  }
  return $regex;
}

sub processCvsWrappersPatterns {
  my %patterns;      # To store unique patterns (surviving any clearing by "!")
  foreach (@_) {     # For each line of wrappers file
    next if /^\s*#/; # Skip comments
    $patterns{$1} = 1 if /^\s*(\S+)/; # (Options _may_ follow on rest of line)
  }
  return keys %patterns;
}

sub processCvsIgnorePatterns {
  my %patterns; # To store unique patterns (surviving any clearing by "!")
  foreach (split(/\s+/, "@_")) { # Sequential processing needed due to "!"
    $patterns{$_} = 1;
    %patterns = () if $_ eq "!";
  }
  return keys %patterns;
}

sub processCvsIgnoreLocal {
  my $urelCwd = shift; # cwd relative to dir where user issued command
  my $subDir = shift; # Directory to look at relative to cwd
  print "Check $subDir/.cvsignore, cwd = " . cwd . "\n" if $debug_cvsignore;
  (my $cvsLocalIgnore = "$subDir/.cvsignore") =~ s|^\./||;
  (my $urel_ign = "$urelCwd/$cvsLocalIgnore") =~ s|^\./||;
  my @cvsLocalIgnoreContents = readCvsConfigFile ($cvsLocalIgnore);
  my @cvsPatIgnoreLocal = @cvsPatIgnore; # Initialize to global ignore patterns
  if (@cvsLocalIgnoreContents) {
    push @cvsSourceIgnoreLocal, $urel_ign;
    push @cvsPatIgnoreLocal, @cvsLocalIgnoreContents;
  }
  return regexFromPatterns (processCvsIgnorePatterns (@cvsPatIgnoreLocal));
}

sub processCvsConfig {
  # Read global CVSROOT/cvsignore and CVSROOT/cvswrappers 
  # from CVS repository using 'cvs checkout -p'.
  # Temporarily disable STDERR echoing (hopefully Window$ compatible)!
  my $cvsGlobalIgnore   = "CVSROOT/cvsignore";
  my $cvsGlobalWrappers = "CVSROOT/cvswrappers";
  $verbose && print "read  $cvsGlobalIgnore\n";
  @cvsPatIgnore = runSilent ("cvs -Q checkout -p $cvsGlobalIgnore");
  $verbose && print "read  $cvsGlobalWrappers\n";
  @cvsPatWrappers = runSilent ("cvs -Q checkout -p $cvsGlobalWrappers");
  if (@cvsPatIgnore) {
    push @cvsSourceIgnore, "\$CVSROOT/$cvsGlobalIgnore";
  }
  if (@cvsPatWrappers) {
    push @cvsSourceWrappers, "\$CVSROOT/$cvsGlobalWrappers";
  }

  # Read local config files $HOME/.cvsignore and $HOME/.cvswrappers
  if (! exists $ENV{'HOME'}) {
    warn "Warning: HOME variable not set.\n";
  } else {
    my $cvsLocalIgnore = "$ENV{'HOME'}/.cvsignore";
    my @cvsLocalIgnoreContents = readCvsConfigFile ($cvsLocalIgnore);
    if (@cvsLocalIgnoreContents) {
      push @cvsSourceIgnore, $cvsLocalIgnore;
      push @cvsPatIgnore, @cvsLocalIgnoreContents;
    }
    my $cvsLocalWrappers = "$ENV{'HOME'}/.cvswrappers";
    my @cvsLocalWrappersContents = readCvsConfigFile ($cvsLocalWrappers);
    if (@cvsLocalWrappersContents) {
      push @cvsSourceWrappers, $cvsLocalWrappers;
      push @cvsPatWrappers, @cvsLocalWrappersContents;
    }
  }

  # Read environment variable CVSIGNORE
  if (exists $ENV{'CVSIGNORE'}) {
    push @cvsSourceIgnore, "\$CVSIGNORE";
    push @cvsPatIgnore, $ENV{'CVSIGNORE'};
  }

  # Compose regular expression of file/dir patterns which are ignored by CVS.
  if (@cvsPatIgnore) {
    @cvsPatIgnore = processCvsIgnorePatterns (@cvsPatIgnore);
  }
  
  # Compose regular expression of file/dir patterns which wrapped by CVS.
  if (@cvsPatWrappers) {
    @cvsPatWrappers = processCvsWrappersPatterns @cvsPatWrappers;
    $cvsRegexWrappers =	regexFromPatterns @cvsPatWrappers;
  }
}

sub processCvs {

  # classification of CVS files and directories
  my @processedDirs;
  my @processedFiles;
  my @locallyModified;
  my @needsMerge;
  my @needsPatch;
  my @lostFiles;
  my @lostDirs;
  my @badDirs;
  my @badFiles;
  my @newDirs;
  my @newFiles;
  my @locallyAdded;
  my @locallyRemovedFiles;
  my @lockedFiles;
  my @conflict;
  my @conflicted;
  my @entryInvalid;
  my @unknownFiles;
  my @unknownDirs;
  my @ignoredDirs;
  my @ignoredFiles;
  my @wrappedDirs;
  my @wrappedFiles;
  my @UptoDate;
  my @StickyFiles;
  my %tags;
  my @other;

  # absolute path to current CVS directory
  my $cvsDirname = shift;

  # check existence of working directory
  if (! -e $cvsDirname) {
    print "Error: $cvsDirname does not exist\n";
    return;
  }

  # change current working directory to CVS working directory
  if (-d $cvsDirname) {
    chdir $cvsDirname;
    $cvsDirname = cwd;
  }

  # optional basename when called for files or wrapped directories
  my $cvsFilename = "";

  # change to parent CVS directory for files and wrapped dirs
  if (-f $cvsDirname || $cvsDirname =~ /$cvsRegexWrappers/) {
    $cvsFilename = basename ($cvsDirname);
    $cvsDirname  = dirname  ($cvsDirname);
    chdir $cvsDirname;
    $cvsDirname = cwd;
    print "$cvsDirname - $cvsFilename\n";
  }

  # check for working CVS in start directory
  if (! -d "CVS") {
    print "Error: No CVS directory in $cvsDirname\n";
    return;
  }
  my $cvsCheckCwd = join ("", runSilent ("cvs -n -q update -l", 1));
  if ($cvsCheckCwd =~ /^cvs \[update aborted\]/m) {
    print "Error: CVS problem in $cvsDirname\n\n$cvsCheckCwd\n";
    return;
  }

  # read full CVS repository path, so that we can remove it.
  # it is the path as seen on the server, no method/host elimination problems.
  # It can vary for each directory if we have a combined module, so use hash.
  my %subDirPrefix;
  my %subRepository;
  $subDirPrefix{'.'} = '';
  $subRepository{'.'} = read_chomp_line "CVS/Repository";

  # read CVS root path, so that we can derive the relative CVS path.
  (my $cvsRoot = read_chomp_line "CVS/Root") =~ s,^.*?:/,,;

  # derive relative CVS path of current working directory
  (my $cvsPath = $subRepository{'.'}) =~ s,^\Q$cvsRoot\E/,,;
  if ($cvsPath eq ".") {
    $cvsPath = "";
  } else {
    $cvsPath = "$cvsPath/";
  }

  # files to process
  my @fnames;
  my @fnamesStatus = ();

  # decide to process file/wrapper or whole directory tree
  if ($cvsFilename) {
    my $cvsRegexIgnore = processCvsIgnoreLocal (".","."); # What to ignore in .
    if ($cvsFilename =~ /$cvsRegexIgnore/) {
      push @ignoredFiles, $cvsFilename;
    } else {
      push @fnames,       $cvsFilename;
      push @fnamesStatus, $cvsFilename;

      $subDirPrefix{$cvsFilename} = (my $dir = dirname $cvsFilename);
      $subRepository{$cvsFilename} = read_chomp_line "$dir/CVS/Repository";
      $verbose && print "repository for $cvsFilename is "
	              . "$subRepository{$cvsFilename}\n";
    }
  } else {
    $verbose && print "scan  directory tree\n";
    my @subDirs;
    my %cvsRegexIgnore; # Regex (value) for files to ignore for given dir (key)
    $cvsRegexIgnore{"."} = '^$'; # Don't ignore `.' inn first call of sub

    # The `find' fills in @subDirs and %cvsRegexIgnore for each relevant dir
    &File::Find::find (sub {
			   # prune any name equal to 'CVS'
			   if (/^CVS$/) {
			     $File::Find::prune = 1;
			     return;
			   }
			   # We only want to look at true subdirs, nothing else
			   return if -l or not -d _;

			   # We work with paths without leading ./
			   (my $subDir = $File::Find::name) =~ s|^\./||;
			   (my $cwd    = $File::Find::dir)  =~ s|^\./||;

			   # Look up regex to ignore for current working dir,
			   # to see if we should ignore the subdirectory found.
			   if (/$cvsRegexIgnore{$cwd}/) {
			     $File::Find::prune = 1;
			     push @ignoredDirs, $subDir; # Statistics only
			     return;
			   }
			   if (/$cvsRegexWrappers/) { # Not yet dir-specific
			     $File::Find::prune = 1;
			     push @wrappedDirs, $subDir; # Statistics only
			     return;
			   }
			   $cvsRegexIgnore{$subDir} =
			       processCvsIgnoreLocal($cwd, $_); # Set regex
			   push @subDirs, $subDir;
		       }
		       , '.');
    if ($debug_cvsignore) {
      for (keys %cvsRegexIgnore) {
	print "RegexIgn($_) = '$cvsRegexIgnore{$_}'\n";
      }
    }
    @subDirs = sort @subDirs;

    # Find unknown files. cvs will only report on them if given as args to it.
    # Find locally added files too. They don't yet exist in the repository,
    # so a `cvs -Q status .' won't reveal their full path name.
    # All other statuses are found by the `cvs -Q status .' later.

    my $subDir;
    foreach $subDir (@subDirs) {
      # scan for files in directory
      my $dh = new DirHandle ($subDir) or die "can't open directory $subDir";
      my @fnamesAdd =
	grep {(-f && (! /$cvsRegexIgnore{$subDir}/ || 
		      (push @ignoredFiles, $_))) 
		|| (-d && /$cvsRegexWrappers/) 
	      } grep {s|^\./|| || 1} map {"$subDir/$_"} sort $dh->read();
      #$dh->close();
      undef $dh;

      # check for working CVS in subdirectory
      $verbose && print "check $subDir\n";
      my $cvsCheckSubDir = $cvsCheckCwd;
      if ($subDir ne ".") {
	$cvsCheckSubDir = 
	  join ("", runSilent ("cvs -n -q update -l $subDir", 1));
      }
      push @wrappedFiles, grep /$cvsRegexWrappers/, @fnamesAdd;
      if ($cvsCheckSubDir =~ /^cvs update: ignoring/m || 
	  $cvsCheckSubDir =~ /^cvs \[update aborted\]/m || 
	  ! -d "$subDir/CVS") {
	my $cvsCheckLost =
	  join ("", runSilent ("cvs -n checkout -p $cvsPath$subDir", 1));
	if ($cvsCheckLost =~ /^cvs checkout: cannot find module/) {
	  push @unknownFiles, @fnamesAdd;
	  push @unknownDirs, $subDir;
	} else {
	  push @badFiles, @fnamesAdd;
	  push @badDirs, $subDir;
	}
      } else {
	push @fnames, @fnamesAdd;
	push @processedDirs, $subDir;

	$subDirPrefix{$subDir} = $subDir;
	$subRepository{$subDir} = read_chomp_line "$subDir/CVS/Repository";
	$verbose && print "repository for $subDir is "
	                . "$subRepository{$subDir}\n";
      }
      if ($show_all) {
	# scan for locked files, used symbolic names, etc.
	my $fileName;
	my $fileLocks = 0;
	my $fileSymNames = 0;
	foreach (runSilent ("cvs log -h -l $subDir")) {
	  if (m|^Working file: (.*)$|) {
	    $fileName = $1;
	  } elsif (m|^locks:|) {
	    $fileLocks = 1;
	  } elsif (m|^symbolic names:|) {
	    $fileSymNames = 1;
	  } elsif (m|^\s\s*(.*):|) {
	    if ($fileLocks) {
	      push @lockedFiles, $fileName;
	    } elsif ($fileSymNames) {
	      $tags{$1} = 1;
	    }
	  } else {
	    $fileLocks = $fileSymNames = 0;
	  }
	}
      }
    }
    @fnamesStatus = @processedDirs;
  }

  if (@fnames) {
    my $status;
    my $fnameStatus;
    foreach $fnameStatus (@fnamesStatus) {
      $verbose && print "read  $fnameStatus\n";
      my $currFile;
      foreach (runSilent ("cvs -Q status -l $fnameStatus", 1)) {
	if (m|^File: (.*)Status: (.*)$|) {
	  my $sfile = $1; # Filename without path, or `no file FILENAME'
	  $status = $2; # May be needed a few lines of cvs output later
	  # CVS sometimes says "Needs Checkout" when it might as well have said
	  # "Needs Patch". In CVS 1.9 I've only seen this for branch-only files
	  # modified by another user.  Translate that special case here.
	  # The remaining (normal) "Needs Checkout" files are the lost ones.
	  $status = "Needs Patch"
	    if $status =~ /Needs Checkout/ and $sfile !~ /^no file /;
	  next;
	}
	# Skip locally added
       if (m|Repository revision.*?\Q$subRepository{$fnameStatus}\E/(.+),v$|) {
	  (my $file = "$subDirPrefix{$fnameStatus}/$1") =~ s|^\./||;
	  push @processedFiles, $file;
	  # Now remove any final `Attic' directory from matched path (CVS 1.9
	  # never has subdirs in its Attic dirs).  This happens for files on
	  # branches that have not been added to the main trunk.
	  $file =~ s,(^|/)Attic/([^/]+),$1$2,;
	  for ($status) {
	    /Locally Modified/    && do {push @locallyModified, $file; next};
	    /Locally Removed/   && do {push @locallyRemovedFiles, $file; next};
	    /Needs Merge/         && do {push @needsMerge,      $file; next};
	    /Needs Patch/         && do {push @needsPatch,      $file; next};
	    /Needs Checkout/      && do {push @lostFiles,       $file; next};
	    /Unresolved Conflict/ && do {push @conflict,        $file; next};
	    /File had conflicts on merge/
	      &&                     do {push @conflicted,      $file; next};
	    /Entry Invalid/       && do {push @entryInvalid,    $file; next};
	    /Up-to-date/          && do {push @UptoDate,        $file; next};
	    push @other, $file;
	  }
          $currFile = $file;
	}
        if (m|^   Sticky Tag:( \|\t)*(.*)|) {
     if ($1 ne "(none)") {
       push @StickyFiles, $currFile." - by Tag: $2";
     }
   }
        if (m|^   Sticky Date:( \|\t)*(.*)|) {
     if ($1 ne "(none)") {
       push @StickyFiles, $currFile." - by Date: $2";
     }
   }
      }
    } 

    # Check all files which are not yet processed an not ignored
    my %processed = map {($_, 1)} (@processedFiles, @ignoredFiles); 
    my @fnamesSh = groupQuotedByDir (grep {! $processed{$_}} @fnames);
    my $fnamesShx;
    my $fcounter;
    my @sstr;
    my $ssstr;
    
    for $fnamesShx (0 .. $#fnamesSh) {
      @sstr = split(" ",$fnamesSh[$fnamesShx][0]);
      for $fcounter (0 .. $#sstr) {
 	$sstr[$fcounter] =~ s/\"//g;
 	foreach (runSilent ("cvs -Q status $sstr[$fcounter]", 1)) {
 	  my ($basename, $status);
 	  # One `File:' for each fname
 	  next unless ($basename, $status) = /^File:\s*(.+)\s+Status: (.+)$/; 
 	  $status =~ /Locally Added/ 
 	      and do {push @locallyAdded, $sstr[$fcounter]; next};
 	  $status =~ /Unknown/
 	      and do {push @unknownFiles, $sstr[$fcounter]; next};
 	}
      }
    }

    # Find new repository files (e.g. added by another user). (ukd 19980426+27)
    # The `2> /dev/null' is needed to discard the cvs warning for lost files.
    # We first find the files that are either new or lost, 
    # then subtract the lost.
    #
    # pas@xis.xerox.com 19981101: Note: 2> /dev/null causes this to fail
    # on windows, since Perl uses cmd.exe and not sh. Why the heck does
    # cvs show "was lost" messages when -q is on? Anyways, this could be
    # made platform specific, i.e. using the $Config::Config{'osname'}.
    my $cvsCheckLostAll;
    if ($cvsFilename) {
      $cvsCheckLostAll =
	join ("", runSilent ("cvs -n -q update $cvsFilename", 1));
    } else {
      $cvsCheckLostAll =
	join ("", runSilent ("cvs -n -q update", 1));
    }
    $cvsCheckLostAll =~ s/^.*was lost$//mg;
    my @newOrLostDirs = 
      grep (! -e,
	    $cvsCheckLostAll
	    =~ /^cvs update: New directory \`(.*)\' -- ignored$/mg);
    my $newOrLostDir;
    foreach $newOrLostDir (@newOrLostDirs) {
      my $newOrLostDirBase = basename ($newOrLostDir);
      my $newOrLostDirPath = dirname ($newOrLostDir);
      my $checkCvsEntriesCmd = "grep \"D/$newOrLostDirBase////\" " .
	"$newOrLostDirPath/CVS/Entries";
      my @checkCvsEntries = runSilent ("$checkCvsEntriesCmd");
      if (@checkCvsEntries) {
	push @lostDirs, $newOrLostDir;
      } else {
	push @newDirs, $newOrLostDir;
      }
    }
    my @newOrLostFiles = grep (! -e, $cvsCheckLostAll =~ /^U (.*)$/mg);
    my %lostFile = map {($_, 1)} @lostFiles; 
    # $lostFile{foo} true if foo lost
    @newFiles = grep {! $lostFile{$_}} @newOrLostFiles;
    
  }

  my $changes = 0;
  if (@locallyModified ||
      @lostFiles ||
      @needsMerge ||
      @needsPatch ||
      @locallyAdded ||
      @locallyRemovedFiles ||
      @unknownDirs ||
      @unknownFiles) {
    $changes = 1;
  }

  printf_header                                 $cvsDirname, $changes;

  printf_arr2     "%s file(s) need(s) merge",    "update",   @needsMerge;
  printf_arr2     "%s file(s) need(s) patch",    "update",   @needsPatch;

  printf_arr2     "%s dir(s) need(s) checkout",  "update",   @lostDirs;
  printf_arr2     "%s file(s) need(s) checkout", "update",   @lostFiles;

  printf_arr2     "%s file(s) locally modified", "commit",   @locallyModified;
  printf_arr2     "%s file(s) locally added",    "commit",   @locallyAdded;
  printf_arr2   "%s file(s) locally removed", "commit", @locallyRemovedFiles;

  printf_arr      "%s file(s) with unresolved conflict(s)",    @conflict;
  printf_arr      "%s file(s) with conflict(s) after merge", @conflicted;

  if ($restrict) {
    printf_scalar "%s dir(s) unknown to cvs",                @unknownDirs;
    printf_scalar "%s file(s) unknown to cvs",               @unknownFiles;
  } else {
    if ($show_all) {
      printf_arr  "%s file(s) locked",                       @lockedFiles;
      printf_arr  "%s tag(s) in use by cvs",                 sort keys %tags;

      printf_arr  "%s dir(s) processed by cvs",              @processedDirs;

      printf_arr  "%s file(s) ignored by cvs",               @ignoredFiles;
      printf_arr  "%s dir(s) ignored by cvs",                @ignoredDirs;
      printf_arr  "%s files(s) wrapped by cvs",              @wrappedFiles;
      printf_arr  "%s dir(s) wrapped by cvs",                @wrappedDirs;
    }
    printf_arr2 
      "%s dir(s) with missing/corrupted cvs info",  "checkout", @badDirs;
    printf_arr
      "%s file(s) with missing/corrupted cvs info",          @badFiles;

    printf_arr2   "%s dir(s) unknown to cvs",    "add",      @unknownDirs;
    printf_arr2   "%s file(s) unknown to cvs",   "add",      @unknownFiles;
  }
  printf_arr      "%s file(s) invalid",                      @entryInvalid;
  printf_arr2     "%s dir(s) locally missing",   "update",   @newDirs;
  printf_arr2     "%s file(s) locally missing",  "update",   @newFiles;
  printf_arr      "%s file(s) with unrecognized cvs status", @other;
  
  if ($show_all) {
    printf_arr    "%s file(s) sticky",                       @StickyFiles;
    printf_arr    "%s file(s) up to date",                   @UptoDate;
    printf_arr    "%s source(s) of local ignore pattern(s)"
      ,                                                  @cvsSourceIgnoreLocal;
    if (@cvsPatIgnore) {
      printf_arr  "%s global pattern(s) in @cvsSourceIgnore", @cvsPatIgnore;
    }
    if (@cvsPatWrappers) {
      printf_arr  "%s pattern(s) in @cvsSourceWrappers",     @cvsPatWrappers;
    }
    printf_footer;
  } else {
    printf_scalar "%s file(s) sticky",                       @StickyFiles;
    printf_scalar "%s file(s) up to date",                   @UptoDate;
  }
  print "\n";
}

&processCvsConfig;
if (@ARGV) {
  my $startCwd = cwd;
  my $cwd;
  foreach $cwd (@ARGV) {
    &processCvs ($cwd);
    chdir $startCwd;
  }
} else {
  &processCvs (".");
}
