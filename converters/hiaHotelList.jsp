<%@ taglib uri="/orbitztaglib.tld" prefix="orbitz" %>
<%@ taglib uri="/c.tld" prefix="c" %>

<%-- Another version of this page exists
	 Changes should be made to both this file and
	 to /dp/search/hia/include/hia_hotel_list.jsp
--%>

<c:choose>
	<c:when test="${DPHIASearchState.isPreviousPageLinkEnabled}">
        <c:set var="hiaFromTarget" value="${DPHIASearchState.previousPage}"/></c:when>
	<c:otherwise>
        <c:set var="hiaFromTarget" value="flightInfo"/></c:otherwise>
</c:choose>

<input type="hidden" name="hiaFromTarget" value="<c:out value="${hiaFromTarget}" />">
<!-- Determine request handler name for href if in lead pricing context -->

<c:set var="url" value="SubmitHIAFlightInformation"/>
<c:if test="${DPHIASearchState.leadPriceSelected}">
    <c:set var="url" value="SubmitHIAHotelSelection"/>
</c:if>

<c:forEach items="${DPHIASearchState.packagePageView.packages}" var="package" varStatus="status">
	<c:set var="packageIndex" value="${status.count}" />
	<%--<c:if test="${package.isBulkAir}"><!--B--></c:if>--%>
	<div class="hotel">
		<div class="header<c:if test="${package.selected}"> prevSelection</c:if>">
			<table><tr>
			
			<td class="cost">
				<h4><c:out value="${package.displayLowestPackageCostPerPerson}"/></h4>
					<c:if test="${package.displayLowestPackageCostPerPerson != package.displayLowestPackageCost}">
						per person<br /><c:out value="${package.displayLowestPackageCost}" />
					</c:if>
					total
				<c:if test="${package.numPackageRates > 0 && package.lowestPackageRateMB.savingsDisplayable}">
					<br /><a href="/App/ViewHIASavings" onClick="return popUpGen('<orbitz:encodeUrl>/App/ViewHIASavings</orbitz:encodeUrl>&hotelIndex=<c:out value="${packageIndex}"/>','600','400');">You save $<c:out value="${package.lowestPackageRateMB.savings}"/></a>
				</c:if>
			</td>
			
			<td class="hotelName">
				<h4>Flight + <a href="#" onclick="noEA();return formHIASubmit('FlightInformationForm','<orbitz:encodeHTTPUrl>/App/<c:out value="${url}"/></orbitz:encodeHTTPUrl>','pkgIndex|<c:out value="${packageIndex}" />','pkgPageNum|<c:out value="${DPHIASearchState.packagePageView.currentPageNum}" />','hiaPkgPg|1','hiaFromTarget|<c:out value="${hiaFromTarget}" />','hiaHotelTarget|details')"><c:out value="${package.hotelEntryMB.propertyName}"/></a></h4>
				<c:if test="${package.selected}">
					<p class="selected">Originally selected hotel</p>
				</c:if>
			</td>

			<td class="stars">
				
				<c:if test="${package.hotelEntryMB.ratingViewable}">
					<orbitz:popup key="hotelStarRating"><img src='/img/dp/hia/star<c:out value="${package.hotelEntryMB.rating.hotelRatingCode}" />.gif' width="70" height="14" alt="<c:out value="${package.hotelEntryMB.rating.hotelRatingCode}" /> star hotel - click for star rating guide"/></orbitz:popup>
				</c:if>
			</td>
			
			</tr></table>
		</div>
		
		<c:if test="${package.hotelEntryMB.roomType.promotionRate}">
			<div class="offerBar">
				<c:choose>
					<c:when test="${package.hotelEntryMB.exclusivePromo}"><orbitz:img key="exclusive_offer_bar"></c:when>
					<c:otherwise><img src="/img/hotel/results/special_offer_bar.gif" width="192" height="18" alt="Orbitz special offer" /></c:otherwise>
				</c:choose>
			</div>
		</c:if>
		
		<div class="body">
			<div class="logo">
				<c:if test="${package.hotelEntryMB.content.logoLinkAvailable}">
					<img src="<c:out value='${package.hotelEntryMB.content.logoLink}'/>" width="82" height="40" alt="" />
				</c:if>
			</div>
			<div class="info">
				<c:if test="${package.hotelEntryMB.content.thumbnailAvailable}">
					<img class="hotelPhoto" src="<c:out value="${package.hotelEntryMB.content.thumbnailLink}" />" alt="" width="120" height="90" />
				</c:if>
				<p class="location"><strong><c:out value="${package.hotelEntryMB.distanceInfo}" /></strong> of <c:out value="${DPHIASearchState.displayMarketLocation}" /></p>
				<p class="description"><c:out value="${package.hotelSummaryMB.shortHotelDescription}" escapeXml="false"/></p>

				<br class="clear">
			
				<div class="select">
					<a class="details" href="#" onclick="noEA();return formHIASubmit('FlightInformationForm','<orbitz:encodeHTTPUrl>/App/<c:out value="${url}"/></orbitz:encodeHTTPUrl>','pkgIndex|<c:out value="${packageIndex}" />','pkgPageNum|<c:out value="${DPHIASearchState.packagePageView.currentPageNum}"/>','hiaPkgPg|1','hiaFromTarget|<c:out value="${hiaFromTarget}" />','hiaHotelTarget|details')">Hotel and room details, photos and maps</a>
					<a href="#" onclick="noEA();return formHIASubmit('FlightInformationForm','<orbitz:encodeHTTPUrl>/App/<c:out value="${url}"/></orbitz:encodeHTTPUrl>','pkgIndex|<c:out value="${packageIndex}" />','pkgPageNum|<c:out value="${DPHIASearchState.packagePageView.currentPageNum}"/>','hiaPkgPg|1','hiaFromTarget|<c:out value="${hiaFromTarget}" />','hiaHotelTarget|details')"><img src="/img/buttons/select_room.gif" width="100" height="19" alt="select a room" /></a>
				</div>
			
				<c:if test="${!FlightInformationPageMB.HIARebateAvailable}">
					<p class="alert">Book now and get <c:out value="${FlightInformationPageMB.inHouseCouponCampaignMB.displayAmount}" /> off your next purchase. <orbitz:popup key="hiaCouponTerms">See coupon for details</orbitz:popup></p>
				</c:if>
			</div>
		</div>
	</div>
</c:forEach>
