#!/usr/bin/perl -w


my @fileList;
my $FAILURE_LIST="~/tmp/failure.test.results";
my $NESTED_JSTL="~/tmp/nestedJstl.test.results";
my $PROPERTY_LIST="~/tmp/property_list.test.results";


##############################################
#
#  Get a list of files.
#   If file names are supplied on command line, take these
#   If script is called without params, apply to current directory
#   and recursively
#
##############################################

if ($#ARGV==-1){
	#@fileList=`find . -name "*jsp" | egrep -v "(admin|ivr|CVS|devtools|WEB-INF|/img/|/images/|marketing|travelwatch|winvegas|spiketv|promos)" | xargs ls`;
		die "Need to specify files for operation";
	}else{
		@fileList=@ARGV;	
	}

		local($^I, @ARGV) = ('.bak', @fileList);
		while (<>) {
			if ($. == 1) {
				if (!/c.tld/){
					print '<%@ taglib uri="/c.tld" prefix="c" %>' . "\n";
				}
			}
			if($.>=2){
			$removeExtraCTaglibDeclaration="<%@ taglib uri=\"/c.tld\" prefix=\"c\" %>";
			s/^$removeExtraCTaglibDeclaration$//;
			}
			
			
			#The order of these tests is important.  An implicit assumption is that the earlier tests will consume
			#matches that would erroneously be changed by later replacements
			# Example.  Replacement of Orbitz.com should be run prior to replacements of Orbitz
			
			
			#get instances of ORBITZSAVER
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.withArticle\']}" />';
				s@an OrbitzSaver\b@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.withGuarantee\']}" />';
				s@\bOrbitzSaver( Low Rate| Hotel)? Guarantee@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.withSM\']}" />';
				s@\bOrbitzSaver<sup>SM</sup>@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.withTM\']}" />';
				s@\bOrbitzSaver&#8482;@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.plural\']}" />';
				s@\bOrbitzSavers\b@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver.email\']}" />';
				s#OrbitzSaverGuarantee\@orbitz.com#$replacement#g;
				$replacement= '<c:out value="${siteProfile.brand[\'hotelSaver\']}" />';
				s@\bOrbitzSaver\b@$replacement@g;

			#get instances of Orbitz LLC with or without numbers (eg CST 2063530-50)
				$replacement= '<c:out value="${siteProfile.brand[\'name.legal.withCST\']}" />';
				s@Orbitz LLC\b( )+CST 2063530-50@$replacement@g;
				$replacement= '<c:out value="${siteProfile.brand[\'name.legal\']}" />';
				s@Orbitz LLC\b@$replacement@g;
				
			#get instance of Orbitz's (plural possessive), convert to Orbitz's
				$replacement= '<c:out value="${siteProfile.brand[\'name.posessive\']}" />';
				s@Orbitz's@$replacement@g;
				
			#get instance of Orbitz' (possessive) convert to Orbitz's
				$replacement= '<c:out value="${siteProfile.brand[\'name.posessive\']}" />';
				s@Orbitz'@$replacement@g;



			$replacement='<c:out value="${siteProfile.brand[\'email.advertise\']}" />';
			  s#AdvertiseOnOrbitz\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.affiliate\']}" />';
			  s#affiliates\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.carrental\']}" />';
			  s#carrental\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.corporate\']}" />';
			  s#orbitzforbusiness\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.corpcom\']}" />';
			  s#corpcom\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.cruise\']}" />';
			  s#orbitzcruise\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.customerService\']}" />';
			  s#customerservice\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.dealDetector\']}" />';
			  s#orbitzdealdetector\@email.orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.editor\']}" />';
			  s#ctang\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.hotelHelp\']}" />';
			  s#hotelhelpdesk\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.hotelSaver\']}" />';
			  s#OrbitzSaverGuarantee\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.hotelShun\']}" />';
			  s#hoteldata\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.info\']}" />';
			  s#info\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.partner\']}" />';
			  s#partner\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.privacy\']}" />';
			  s#privacy\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.recruiting\']}" />';
			  s#resume\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.sitefeedback\']}" />';
			  s#sitefeedback\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.spam\']}" />';
			  s#spam\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.support\']}" />';
			  s#orbitzsupport\@orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.ticketResolution\']}" />';
			  s#ticketresolution\@Orbitz.com#$replacement#gi;
			$replacement='<c:out value="${siteProfile.brand[\'email.travelercare\']}" />';
			  s#travelercare\@orbitz.com#$replacement#gi	;
			$replacement='<c:out value="${siteProfile.brand[\'email.vacations\']}" />';
			  s#orbitzvacations\@orbitz.com#$replacement#gi	;				
				
			$replacement='<c:out value="${siteProfile.brand[\'website.CAPS\']}" />';
				s@ORBITZ.COM@$replacement@g;					

			$replacement='<c:out value="${siteProfile.brand[\'website\']}" />';
				s@www.orbitz\.com@$replacement@g;	
				
			#replace http://orbitz.com with www.orbitz.com	
			$replacement='<c:out value="${siteProfile.brand[\'website\']}" />';
				s@(http://)orbitz\.com@$1$replacement@;		
			
			# replace orbitz.com or Orbitz.com in text with Orbitz.com	
			$replacement='<c:out value="${siteProfile.brand[\'name.withDomain\']}" />';
				s#([^\./@])orbitz\.com#$1$replacement#gi;				
				
			#get instances of Orbitz.com
			$replacement='<c:out value="${siteProfile.brand[\'name.withDomain\']}" />';
				s#([^\.@])Orbitz.com\b#$1$replacement#gi;

			#replace Orbitz
				$replacement='<c:out value="${siteProfile.brand[\'name\']}" />';
				s@\bOrbitz\b@$replacement@g;

			
			#replace customer service URL
				$replacement='<c:out value="${siteProfile.brand[\'customer.service\']}" />';
				s@http://faq.orbitz.com/cgi-bin/orbitz.cfg/php/enduser/home.php@$replacement@;
			
			#replace ORBITZ'S
				$replacement='<c:out value="${siteProfile.brand[\'name.CAPSPosessive\']}" />';
				s@\bORBITZ'S\b@$replacement@g;

			#replace ORBITZ'S
				$replacement='<c:out value="${siteProfile.brand[\'name.CAPS\']}" />';
				s@\bORBITZ\b@$replacement@g;
			
			#replace customer service URL
			#need to add filter for rpts
			$replacement='<c:out value="${siteProfile.brand[\'website\']}" />';
				s@http://www.orbitz\.com@$replacement@;

			  
			  
			$replacement='<c:out value="${siteProfile.brand[\'policy.updated\']}" />';
				s#March 12, 2005#$replacement#gi;							
		 	print;
			close ARGV if eof;              # Reset $.
		}

		#grep  -ri --include="*jsp" "orbitz" . | grep -v "orbitz:" | egrep -v "(orbitztaglib|admin|ivr|CVS|devtools|WEB-INF|/img/|/images/|marketing|travelwatch|winvegas|spiketv|promos)" > failure.list
##egrep -ri --include="*jsp" "<c:[^>]*<c:" . > nested.jstl
##
##cat ~/go | egrep "siteProfile\.brand" | grep -v "^#" | sed "s/^.*\.brand\[\\\'\([^\\]*\)\\\'\].*$/\1/"  | sort | uniq -u > property.list.in.files
##for props in `cat property.list.in.files`; do echo "property:" $props `fgrep -c $props ~/props/web/ocom/view/brand.properties`; done; 
##
##vi failure.list nested.jstl property.list.in.files
		
		
		
		
#
# < <c:when test="${OTPDetails.travelProtection.productName=='<c:out value="${siteProfile.brand['name']}" /> Rental Car Coverage'}">
#<       <h3 class="notch"><c:out value="${siteProfile.brand['name']}" /> Rental Car Coverage</h3>
#---
#
#
#
#
#
#

#	This regex is not used in the file, but is useful to convert property=value to replacemetn syntax below
#  s/\([^=]*\)=\(.*\)$/$replacement='<c:out value="$siteProfile.brand[\\'\1\\']}" \/>'\r\ts#\2#replacement#gi/ 
#
# example: run regex on:
#  mail.advertise=AdvertiseOnOrbitz@orbitz.com
# get this back
# $replacement='<c:out value="$siteProfile.brand[\'email.advertise\']}" />'
#  s#AdvertiseOnOrbitz@orbitz.com#replacement#gi
#
#chmod +x ~/go
##find . -name "*jsp" | egrep -v "(admin|ivr|CVS|devtools|WEB-INF|/img/|/images/|marketing|travelwatch|winvegas|spiketv|promos)" | xargs -n1 ~/go 
##
##
##grep  -ri --include="*jsp" "orbitz" . | grep -v "orbitz:" | egrep -v "(orbitztaglib|admin|ivr|CVS|devtools|WEB-INF|/img/|/images/|marketing|travelwatch|winvegas|spiketv|promos)" > failure.list
##egrep -ri --include="*jsp" "<c:[^>]*<c:" . > nested.jstl
##
##cat ~/go | egrep "siteProfile\.brand" | grep -v "^#" | sed "s/^.*\.brand\[\\\'\([^\\]*\)\\\'\].*$/\1/"  | sort | uniq -u > property.list.in.files
##for props in `cat property.list.in.files`; do echo "property:" $props `fgrep -c $props ~/props/web/ocom/view/brand.properties`; done; 
##
##vi failure.list nested.jstl property.list.in.files
##	


