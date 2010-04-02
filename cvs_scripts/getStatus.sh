
##################################################
#  Convenience methods for getting CVS status
##################################################


# init

TMPFile=/tmp/status.cvs.tmp   # location of tmp working file
KEEPFile=/tmp/status.cvs 		# location of file for maintaining status
PROJECTHOME=~/webapp    
#PROJECTHOME=~/branch
function getCVSStatus()
	{
	export CVS_RSH=ssh
	export CVSROOT=:ext:nkrimm@krimm.net:/home/nkrimm/CVSROOT
	cvs -q status | cat > $KEEPFile					#get cvs status and write to file 
	grep "Status: Locally Modified" $KEEPFile | cat >> $TMPFile  
	egrep "\b[Mm]erge" $KEEPFile | cat >> $TMPFile	# need both.  Merged and conflicts on merge
	grep "Unknown" $KEEPFile | cat >> $TMPFile
	grep "?" $KEEPFile | cat >> $TMPFile
	grep "Status: Needs Checkout" $KEEPFile | cat >> $TMPFile
	grep "Status: Needs Patch" $KEEPFile | cat >> $TMPFile # needs patch
  grep "Status: Locally Added" $KEEPFile | cat >> $TMPFile
  mv $TMPFile $KEEPFile
	}
	
function generateOutput()
{
	if [ -s $KEEPFile ]  #$KEEPFile is >0 length.  Occurs if there is any result to query
		 then
		 	cat $KEEPFile
		 else
			 echo
			 echo "All CVS files in sync with repository"
	fi	
}


clear
	
case $1 in 
-h)   # show help information
	echo "options:"
	echo "-p: display previous status file"
	echo "-c: run on current directory only"
	echo "with no parameters, the script checks the whole CVS tree"
	echo
	exit 0
	;;
	
-p)    # parameter to show current status only
	echo Displaying previous status file:
	echo ""
	generateOutput
	;;
-c)  # status of current directory instead of whole tree
	echo "Status of current directory: [$pwd ]"
	getCVSStatus
	generateOutput
	;;
*)   # with no parameters, run script in home directory
#	echo "Status of full CVS tree: $PROJECTHOME"
#	cd $PROJECTHOME
	getCVSStatus
	generateOutput	
	;;
esac

echo 
echo
exit 0


