use strict;                   
use warnings; 
use 5.10.0;
use JSON;
use Data::Dumper;             

my $info_json = '[{"time":1097791200,"category":"Games"},{"time":1097791200,"category":"Movies"}]';
 
my $info_decoded_json = from_json( $info_json );
foreach my $hr (@$info_decoded_json) {
   say sprintf("%s %s", $hr->{time}, $hr->{category});
}

 
 

