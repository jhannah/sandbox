#!/usr/bin/perl

use strict;

my $dir = '/home/jhannah/.irssi';

our @servers = (
   {
      name    => 'perl', 
      address => 'irc.perl.org',
   },
   {
      name        => 'freenode', 
      address     => 'irc.freenode.net',
      autosendcmd => "/nick deafferret; /msg nickserv identify passwordhere; wait 2000",
   },
   {
      name    => 'uno', 
      address => 'bioirc.ist.unomaha.edu',
   },
   {
      name     => 'ii', 
      address  => 'gw.iinteractive.com',
      password => 'passwordhere',
      use_ssl  => 'yes',
      port     => 6668,
   },
   {
      name        => 'flowdock', 
      address     => 'irc.flowdock.com',
      use_ssl     => 'yes',
      port        => 6697,
      autosendcmd => "/msg nickserv identify jay.hannah\@iinteractive.com passwordhere; wait 2000",
   },
);

our @channels = qw(
   10   #perl-help      perl            
   11   #perl++         perl            
   12   #uno            uno        
   13   #OmahaLUG       freenode        
   14   #omaha.dev      freenode        
   15   #omahamaker     freenode        
   16   #mongers        perl            
   17   #bioperl        freenode        
   30   #axkit-dahut    perl            
   31   #perl           perl            
   40   #moose          perl            
   41   #moose-dev      perl            
   42   #kiokudb        perl            
   43   #plack          perl            
   50   #catalyst       perl            
   51   #catalyst-dev   perl            
   52   #tt             perl            
   53   #poe            perl            
   54   #dbix-class     perl            
   55   #perl-qa        perl            
);


open my $out, ">", "$dir/config" or die;

{
   local @servers = @servers;
   print $out "servers = (\n";
   foreach my $s (@servers) {
      # next unless ($s->{name} eq 'ii');
      my $use_ssl = $s->{use_ssl} || 'no';
      my $port =    $s->{port}    || '6667';
      print $out <<EOT;
   {
     address = '$s->{address}';
     chatnet = '$s->{name}';
     port = '$port';
     use_ssl = '$use_ssl';
     ssl_verify = 'no';
     autoconnect = 'yes';
     password = '$s->{password}';
   },
EOT
   }
   print $out ");\n";
}


{
   local @servers = @servers;
   print $out "chatnets = {\n";
   foreach my $s (@servers) {
      if ($s->{autosendcmd}) {
         print $out "  $s->{name} = { type = 'IRC'; autosendcmd = '" . $s->{autosendcmd} . "'; };\n";
      } else {
         print $out "  $s->{name} = { type = 'IRC'; };\n";
      }
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



