#!/usr/bin/perl

# History
#
# 03/14/98 1.2.7  - Added source domain exclusions and inclusions
#
# 11/14/97 1.2.6  - Added major version report
#
# 07/05/97 1.2.5  - Added options to filter analysed log entries
#                   when using a 'combined' or 'reverse-combined' 
#                   format log
#
# 04/03/96 1.2.4  - Re-optimized loops for speed at the suggestion
#                   of Scott Moskalik <smoskali@adobe.com>.
#                   Also added support for compressed log files
#                   and streamlined the report generator somewhat.
#
# 01/14/96 1.2.3  - Fixed problem where browsers that had NO version
#                   number were being lumped in with 'unknown' browsers.
#                   Problem identified by Ronald Hello
#                   <Ronald.Hello@cs.utwente.nl>
#
# 12/24/96 1.2.2  - Added handler for 'reverse-combined' log formats
#                   where the agent is put *before* the referrer in
#                   the log. Also added URL encoding decoder
#                   to handle other oddities resulting from this
#                   non-standard log format.
#
# 12/09/96 1.2.1  - Added special handler for WebTV since it spoofs
#                   as MSIE 2.0 spoofing as Mozilla 1.22. Presumably
#                   this is to bypass MS's infamous 'MSIE only' sites.
#
# 08/28/96 1.2    - Added in multiple levels of summary to lump
#                   versions in a more useful manner. Change made 
#                   at request of Thomas Reardon <thomasre@MICROSOFT.com>.
#                   Added 'html-safing' of output.
#
# 07/08/96 1.1.1c - Added general purpose despoofer for pseudo-standard
#                   of 'compatible' Mozilla spoofers.
#
# 07/08/96 1.1.1b - Fixed bug in handling of proxies information
#                   Change suggested by James Walter Martin III <jwm3@chubb.com>
#
# 12/26/95 1.1.1a - Fixed minor typo for default handling of $HTTPDAGENT.
#                   Thanks go to Helmut Oertel <oertelh@cs.tu-berlin.de>
#                   for spotting the error.
# 
# 12/21/95 1.1.1  - Added anti-spoofing for MSIE and zeroed out percentages of less 
#                   than 0.001% 
#
# 11/12/95 1.1    - Command line controls, include files, multiple logs 
#
# 8/28/95  1.0.1  - Added sorting by percentage for summary,
#                   improved combining of variants for browers 
#                   in summary, reoptimized scan loop for
#                   speed (the test run counted 200K hits in 
#                   less than a minute!) and changed usage
#                   of <br> to \n to handle a few Perl variants
#                   that choked on a single line for the entire
#                   output table.

# Don't write me email about 'ctime.pl' - it is a standard
# part of perl. If it isn't on your system, your perl
# is mis-installed.

require "ctime.pl";

$browserversion="1.2.7";

# Type of log file being parsed ('agent','combined','reverse-combined')
$LogType='combined';

# path to the agent_log
$HTTPDAGENT="/var/log/httpd/access_log";

# Name of server
$HTTPDSERVER='68.112.38.163';

# Exclusion Filter (example filter excludes jpegs, gifs and png files)
# uncomment to use
# $ExcludeAllRefsTo='\.([Gg][Ii][Ff]|[Jj][Pp][Ee]?[Gg]|[Pp][Nn][Gg])$';

# Inclusion Filter (default filter is for 'text-like' requests)
$IncludeOnlyRefsTo='(\/|\.[ps]?html?|\.txt)$';

# Domain Exclusion filter (uncomment and change as needed to use)
# $ExcludeDomains='198\.60\.|204\.228\.|166\.70\.|207\.135\.|199\.104\.120\.|xmission';

# Domain Inclusion filter (uncomment and change as needed to use)
# $IncludeDomains='\.net$';

# For decompressing gzipped logs 
$ungzip = "/bin/gzip -cd";
 
&Initialize;

&IncludeOldFile if ($IncludeFile);

@ARGV=($HTTPDAGENT) if ($#ARGV == -1);

foreach $HTTPDAGENT (@ARGV) {
        $OpeFile=$HTTPDAGENT;
        if ($OpeFile =~ m#\.gz$#o) {
                $OpeFile="$ungzip $HTTPDAGENT |";
        }
        if (! open(AGENTLOG,$OpeFile) ) {
                warn "Can't open ${HTTPDAGENT}. Skipped.\n $!";
                next;
        }
	# Combined log format
	if ($LogType eq 'combined') {
	  while ($line=<AGENTLOG>) {
	    chop $line;
	    ($Domain,$rfc931,$authuser,$TimeDate,$Request,$Status,$Bytes,$Referrer,$Agent) = $line =~
	       /^(\S+) (\S+) (\S+) \[([^\]\[]+)\] \"([^"]*)\" (\S+) (\S+) \"?([^"]*)\"? \"([^"]*)\"/o;
	    ($Method,$FileName,$Protocal)=split(/\s/o,$Request,3);

            # Domains to be excluded from report
            next if ($ExcludeDomains && ($Domain =~ m/$ExcludeDomains/oi));

            # Domains to be *included* in report (all others excluded)
            next if ($IncludeDomains && (! ($Domain=~m/$IncludeDomains/oi)));

            if ($IncludeOnlyRefsTo && (! ($FileName=~m/$IncludeOnlyRefsTo/o))) {
                next;
            }
            if ($ExcludeAllRefsTo && ($FileName =~ m/$ExcludeAllRefsTo/o)) {
                next;
            }
	    $refscounter++;
            if (! ($Domain || $Agent)) {
	        $Agent = "Unparsable Log Entry";
            }
	    $RAgents{$Agent}++;
	  }
	# Combined log format where user agent and referrer are transposed
	} elsif ($LogType eq 'reverse-combined') {
	  while ($line=<AGENTLOG>) {
	    chop $line;
	    ($Domain,$rfc931,$authuser,$TimeDate,$Request,$Status,$Bytes,$Agent,$Referrer) = $line =~
	       /^(\S+) (\S+) (\S+) \[([^\]\[]+)\] \"([^"]*)\" (\S+) (\S+) \"([^"]*)\" ([^"]*)/o;
	    ($Method,$FileName,$Protocal)=split(/\s/o,$Request,3);

            # Domains to be excluded from report
            next if ($ExcludeDomains && ($Domain =~ m/$ExcludeDomains/oi));

            # Domains to be *included* in report (all others excluded)
            next if ($IncludeDomains && (! ($Domain=~m/$IncludeDomains/oi)));

            if ($IncludeOnlyRefsTo && (! ($FileName=~m/$IncludeOnlyRefsTo/o))) {
                next;
            }
            if ($ExcludeAllRefsTo && ($FileName =~ m/$ExcludeAllRefsTo/o)) {
                next;
            }
	    $refscounter++;
            if (! ($Domain || $Agent)) {
	        $Agent = "Unparsable Log Entry";
            }
	    $RAgents{$Agent}++;
	  }
	# Standard agent_log
	} elsif ($LogType eq 'agent') {
	  while ($line=<AGENTLOG>) {
	    $refscounter++;
	    chop $line;
	    $RAgents{$line}++;
	  }
	}
}

while(($Agent,$Count) = each(%RAgents)) {

	  if (($Agent eq "-") || (! $Agent)) {
	    $Agent = "Unknown";
	  } else {
            $line =~ s#\s+# #go; # Fixes proxy info bug. Fix suggested by
                                 # James Walter Martin III <jwm3@chubb.com>
	    # Undo any URL encoding of user agent
	    $Agent =~ tr/+/ /;
	    $Agent =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

	    # Despoofs WebTV spoofing as MSIE spoofing as Mozilla.

	    if ($Agent =~ m#^\S+\s+(WebTV/\S+)#o) {
		$Agent = "$1 spoofing as $Agent";
	    } else {

	      # despoofs people using pseudo-'standard' of 'compatible'

	      if ($Agent =~ m#^Mozilla.*\(compatible; *([^;)]+)#oi) {
	        $spoofer =  $1;
	        $spoofer =~ s#/#-#og;
	        $spoofer =~ s/\W+$//o;
	        $Agent="$spoofer spoofing as $Agent";
	      }
	    }
	    # Lets not let children play with dangerous toys...

	    $Agent =~ s#<#\&lt;#go;
	    $Agent =~ s#\&#\&amp;#go;
	    $Agent =~ s#>#\&gt;#go;
	    $Agent =~ s#"#\&quot;#go;
	  }
	  $rawagents{$Agent}+=$Count;
}

foreach $agent (keys (%rawagents)) {
  $longagent=$agent;

  ($base)          =  $longagent =~ m#^([^\(\[]+)#o;
  $base            =~ s#\s+$##o;
  $base            =~ s#via proxy.*$##ogi;

  ($name,$version) = $base =~ m#^([^\d\/]+)[\s\/vV]+(\d[\.\d]+)#o;
  ($name) = $base =~ m#^([^\d\/]+)#o if (! $name);
  $agentgroup{$name}               += $rawagents{$agent};
  $agentversion{"$name $version"}  += $rawagents{$agent};
  $baseagent{$base}                += $rawagents{$agent};
}

if ($OutputFile) {
	open (OUTPUT,">$OutputFile") ||
		die ("Could not open $OutputFile for writing.\n$!");
	select(OUTPUT);
}
$date=&ctime(time);
print <<"EOF";
<!doctype HTML public "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>Web Browser Agent Statistics for ${HTTPDSERVER}</title>
</head>
<body>
<h1 align=center>Web Browser Agent Statistics for ${HTTPDSERVER}</h1>
<p>
Logged web browser agents accessing ${HTTPDSERVER}.<br>
Last updated: $date
$refscounter hits measured this run.
</p>

<h2>Summary in broad:</h2>

<table border=3>
<tr>
  <th>Hits</th>
  <th>Percent</th>
  <th>Browser
</th>
</tr>
EOF
foreach $key (sort AgentByHits keys(%agentgroup)) {
        print "<tr>\n  <td align=right>$agentgroup{$key}</td>\n  <td align=left>";
        $percentage=100*$agentgroup{$key}/$refscounter;
	$percentage = 0.00 if ($percentage < 0.001);
        $percentage=~s/(....).*/$1/o;
        print "${percentage}\%</td>\n  <td>$key</td>\n</tr>\n";
}
print <<"EOF";
</table>

<h2>Summary by major version:</h2>

<table border=3>
<tr>
  <th>Hits</th>
  <th>Percent</th>
  <th>Browser</th>
</tr>
EOF

foreach $key (keys(%agentversion)) {
	$mversion = $key;
	$mversion =~ s/(\d+)\.\d+([^\.].*$|$)/$1/og;
	$majorversion{$mversion}+=$agentversion{$key};
}

foreach $key (sort MajorVersionByHits keys(%majorversion)) {
        print "<tr>\n  <td align=left>$majorversion{$key}</td>\n",
		"  <td align=left>";
        $percentage=100*$majorversion{$key}/$refscounter;
	$percentage = 0.00 if ($percentage < 0.001);
        $percentage=~s/(....).*/$1/o;
        print "${percentage}%</td>\n  <td>$key</td>\n</tr>\n";
}
print <<"EOF";
</table>

<h2>Summary by minor version:</h2>

<table border=3>
<tr>
  <th>Hits</th>
  <th>Percent</th>
  <th>Browser</th>
</tr>
EOF
foreach $key (sort VersionByHits keys(%agentversion)) {
        print "<tr>\n  <td align=left>$agentversion{$key}</td>\n",
		"  <td align=left>";
        $percentage=100*$agentversion{$key}/$refscounter;
	$percentage = 0.00 if ($percentage < 0.001);
        $percentage=~s/(....).*/$1/o;
        print "${percentage}%</td>\n  <td>$key</td>\n</tr>\n";
}
print <<"EOF";
</table>

<h2>Summary by fine detail of version:</h2>
<table border=3>
<tr>
  <th>Hits</th>
  <th>Percent</th>
  <th>Browser</th>
</tr>
EOF
foreach $key (sort BaseByHits keys(%baseagent)) {
        print "<tr>\n  <td align=left>$baseagent{$key}</td>\n  <td>";
        $percentage=100*$baseagent{$key}/$refscounter;
	$percentage = 0.00 if ($percentage < 0.001);
        $percentage=~s/(....).*/$1/o;
        print "${percentage}\%</td>\n  <td>$key</td>\n</tr>\n";
}

print <<"EOF";
</table>

<h2>Detailed Report:</h2>
<table border=3>
<tr>
  <th>Hits</th>
  <th>Browser</th>
</tr>
EOF

foreach $key (sort keys(%rawagents)) {
        print "<tr>\n  <td>";
        printf "%7u",$rawagents{$key};
	print "</td>\n  <td>$key</td>\n</tr>\n";
}

print <<"EOF";
</table>
<hr>
<p>
Statistics generated by <a 
href=\"http://www.netimages.com/~snowhare/utilities/browsercounter.html\">BrowserCounter 
$browserversion</a></p>
</body>
</html>
EOF

select (STDOUT) if ($OutputFile);

sub AgentByHits {
	$ahits=$agentgroup{$a};
	$bhits=$agentgroup{$b};
	$bhits<=>$ahits;
}

sub VersionByHits {
	$ahits=$agentversion{$a};
	$bhits=$agentversion{$b};
	$bhits<=>$ahits;
}

sub MajorVersionByHits {
	$ahits=$majorversion{$a};
	$bhits=$majorversion{$b};
	$bhits<=>$ahits;
}
sub BaseByHits {
	$ahits=$baseagent{$a};
	$bhits=$baseagent{$b};
	$bhits<=>$ahits;
}

sub IncludeOldFile {
	if (! open (INCLUSION,$IncludeFile)) {
		warn "Could not open $IncludeFile for inclusion.\n$!";
		return;
	}
	$startdata=0;
	while ($line = <INCLUSION>) {
		chop $line;
		if ( (! $startdata) && ($line eq '<tr><th>   Hits</th>  <th>Browser')) {
			$startdata++;
			next;
		}
		if ($line =~ 
		m#</tr><tr><td>\s*(\d+)</td> <td>(.*)$#o ) {
			$agentversions{$2}+=$1;
			$refscounter += $1;
		}
	}
	close(INCLUSION);
}

sub Initialize {
	&ReadCommandLine('include:output:name:logtype:exfrom:exto:minrefs');

	# Old file to read (optional)
	$IncludeFile = $opt{'include'} if ($opt{'include'});

	# Output file (optional - goes to STDOUT if not specified)
	$OutputFile = $opt{'output'} if ($opt{'output'});

	# Type of log (legal: combined, referer)
	$LogType = $opt{'logtype'} if ($opt{'logtype'});

	# Name of server
	$HTTPDSERVER=$opt{'name'} if ($opt{'name'});
}

sub ReadCommandLine {

        # parse list has the form 'a:b:c'
        # flags with parse list entries must take values

        local($parselist)=$_[0];
        local(@CommandLine)=@ARGV;
        local(@ParseList,%ParseRules,@GenericList);

        (@ParseList)=split(/:/,$parselist);

        foreach $item (@ParseList) {
                $ParseRules{$item}=1;
        }

        while ($parm=shift(@CommandLine)) {
                if ($parm =~ m#^\-([a-zA-Z]+)$#o) {
                        $parm=$1;
                        $opt{$parm}=1;
                        if ($ParseRules{$parm}) {
                                $value=shift(@CommandLine);
                                if ($value eq "") {
                                        die ("Invalid comand line switch usage, '-$parm' requires value\n");
                                }
                                $opt{$parm}=$value;
                        }
                        next;
                }
                push(@GenericList,$parm);
        }
        @ARGV=@GenericList;
}

