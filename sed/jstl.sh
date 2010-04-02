#<%@ include file="/global/nav/<jsp:include page="/global/nav/top.jsp"/>.jsp" %>
#with 
#<%@ include file="/global/nav/top.jsp" %>


s/prefix="orbitz"/prefix="o"/g
s/<\(.\?\)orbitz:/<\1o:/g

# note this turns define into model bean reference.   should determine if model bean reference, but we'll have to do it manually
s/<o:define id="\(.*\)" value="\(.*\)" \/>/<c:set id="\1" value="\$\{\2\}" \/>/g
s/<o:ifnotequals property="\(.*\)" constant="\(.*\)">/<c:if test="\$\{\1!=\2\}">/g
s/<o:ifequals property="\(.*\)" constant="\(.*\)">/<c:if test="\$\{\1==\2\}">/g
s/<o:valueof property="\(.*\)"\(.\?\)\/>/<c:out value="\$\{\1\}" \/>/g


#need to replace : with . inside of <c:  ""/>
#very goofy hack below

/\${.*}/s/:/./g
s/<c./<c:/g

