#!/usr/bin/perl

use strict;

my $dir = '/home/jhannah/.irssi';

our @servers = qw(
   perl     irc.perl.org         undef
   freenode irc.freenode.net     undef
   acme     irc.acme.com         password
);

our @channels = qw(
   10   #perl-help      perl            
   11   #OmahaLUG       freenode        
   12   #omaha.dev      freenode        
   13   #omahamaker     freenode        
   16   #yapcadmins     perl            
   17   #mongers        perl            
   18   #bioperl        freenode        
   30   #acme           acme
   40   #moose          perl            
   41   #moose-dev      perl            
   42   #kiokudb        perl            
   43   #plack          perl            
   44   #ox             perl            
   50   #catalyst       perl            
   51   #catalyst-dev   perl            
   52   #tt             perl            
   53   #poe            perl            
   54   #dbix-class     perl            
   55   #perl-qa        perl            
   60   #axkit-dahut    perl            
);


open my $out, ">", "$dir/config" or die;

{
   local @servers = @servers;
   print $out "servers = (\n";
   while (my ($name, $address, $password) = splice @servers, 0, 3) {
      print $out <<EOT;
   {
     address = '$address';
     chatnet = '$name';
     port = '6667';
     use_ssl = 'no';
     ssl_verify = 'no';
     autoconnect = 'yes';
     password = '$password';
   },
EOT
   }
   print $out ");\n";
}


{
   local @servers = @servers;
   print $out "chatnets = {\n";
   while (my ($name, $address, $password) = splice @servers, 0, 3) {
      print $out "  $name = { type = 'IRC'; };\n";
   }
   print $out "};\n";
}


{
   local @channels = @channels;
   print $out "channels = (\n";
   while (my ($num, $name, $net) = splice @channels, 0, 3) {
      print $out "  { name = '$name'; chatnet = '$net'; autojoin = 'yes'; },\n";
   }
   print $out ");\n";
}


{
   local @channels = @channels;
   print $out <<EOT;
windows = {
  1 = { immortal = "yes"; name = "(status)"; level = "ALL"; };
EOT
   while (my ($num, $name, $net) = splice @channels, 0, 3) {
      print $out <<EOT;
  $num = {
    items = (
      { 
        type = "CHANNEL";
        chat_type = "IRC";
        name = "$name";
        tag = "$net";
      }
    );
  };
EOT
   }
   print $out "};\n";
}


`cat $dir/config.static >> $dir/config`;



