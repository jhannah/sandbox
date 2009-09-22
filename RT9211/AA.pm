package AA;
use FindBin qw($Bin);
our $home = $Bin;
$home =~ s#/Omni2.*##;
warn "AA $home";

1;

