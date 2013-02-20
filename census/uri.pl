use strict;
use 5.10.0;
use URI;
use URI::QueryParam;

# Copy/paste ugliness...
my $uri = URI->new('http://search.ancestry.com/cgi-bin/sse.dll?db=1940usfedcen&rank=1&new=1&so=3&MSAV=1&msT=1&gss=ms_r_db$query&gsfn_x=XO&gsln_x=XO&msbdy_x=1&msbpn_x=XO&msbpn__ftp_x=1&dbOnly=_F0007258|_F0007258_x&dbOnly=_F0007257|_F0007257_x&dbOnly=_F0007256|_F0007256_x&dbOnly=_F000686E|_F000686E_x&dbOnly=_F0006AB0|_F0006AB0_x&dbOnly=_83004005-n|_83004005-n_x&dbOnly=_83004006-n|_83004006-n_x&_83004002_x=1&uidh=y8c&_83004003-n_xcl=f');

my %args2 = (gsfn => 17, gsln => 12);
$uri->query_param_append(%args2);
say $uri;



__END__

00:19 < deafferret> 'sse.dll?db=1940usfedcen&rank=1&...' in source code is ugly. that's all I meant.
00:19 < deafferret> Not your fault, that's their URL.
00:19 < deafferret> pretty source code looks like   (db => '1940usfedcen', rank => 1, ...)
00:20 < deafferret> source code, ideally, doesn't have long squished strings of goop in it
00:20 < deafferret> separating logic from formats is always good.
00:21 < deafferret> but, in this case, not worth bothering with, in my opinion
00:21 < deafferret> for the initial $uri. But it IS worth bothering with for all the arguments that YOU'RE 
                    ADDING with your logic
00:21 < deafferret> which, currently, is hard to keep track of. in my opinion.

