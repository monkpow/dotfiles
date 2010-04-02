#!/usr/bin/perl -w

#<img src="/img/icons/error.gif" border="0" alt="" />
#<img src="/img/icons/dp_air.gif" width="25" height="16" align="left" style="margin-right:6px;" />
#<img src="/img/icons/dp_air.gif" width="25" height="16" class="icon" />
#<img src="/img/icons/dp_hot.gif" width="25" height="16" class="icon" />
#<img src="/img/hotel/results/special_offer_bar.gif" width="192" height="18" alt="orbitz special offer" />
#<img src="/img/icons/promo_sm.gif" alt="Promo" width="13" height="13" border="0" class="icon" />
#<img src="/img/icons/promo_sm.gif" alt="Promo" width="13" height="13" border="0" class="icon" />
#<img src="/img/hotel/results/exclusive_offer_bar.gif" width="210" height="18" alt="Orbitz exclusive offer" />
#<img src="/img/hotel/results/special_offer_bar.gif" width="192" height="18" alt="Orbitz special offer" />
#<img name="card_back" src="/img/air/cc_mc.gif" width="237" height="137" alt="" border="0">
#<img name="card_back" src="/img/air/cc_mc.gif" width="237" height="137" alt="" border="0">
#<img name="card_back" src="/img/air/cc_amex.gif" width="237" height="137" alt="" border="0">
#<img name="card_back" src="/img/air/cc_amex.gif" width="237" height="137" alt="" border="0">
#<img name="card_back" src="/img/air/cc_visa.gif" width="237" height="137" alt="" border="0">
#<img src="/img/corners/12x12_cef_f_tr.gif" alt="" width="12" height="12" />
#<img src="/img/icons/error.gif" width="13" height="13" class="icon" alt="" />
#<img src="/img/corners/12x12_cef_f_br.gif" alt="" width="12" height="12" />
#<img src="/img/amex_logo.gif" class="amExModIcon" align="right"/>
#<img src="/shared/img/logos/amex_rail.gif" width="150" height="38" alt="">
#<img src="/img/exitapp/dealdetector.gif" alt="DealDetector" />
#<img src="/img/global/callout_telesales.gif" width="139" height="65" alt="Need help booking your trip?" class="major" />
my $src;
my $alt;
my $height;
my $width;

while (<>){
chomp;

if ($_ =~ m/\/([^\/]*\/)*(.*)(\.gif)/){
	$key=$2;
}
	

if ($_ =~ m/src="([^"]*)"/i) {
	 $src=$1
}

if ($_ =~ m/alt="([^"]*)"/i) {
	 $alt=$1
}

if ($_ =~ m/height="([^"]*)"/i) {
	 $height=$1
}

if ($_ =~ m/width="([^"]*)"/i) {
	 $width=$1
}
print "\n# $key\n";
print "$key.alt=$alt \n";
print "$key.src=$src \n";
print "$key.height=$height \n";
print "$key.width=$width \n";
}
