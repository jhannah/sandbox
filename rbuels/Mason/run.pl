#!/usr/bin/env perl
# render the template into the target file
use strict;
use warnings;
 
use Cwd;
use HTML::Mason::Interp;
 
my $mason = HTML::Mason::Interp
    ->new( autohandler_name => '',
           comp_root => [['conf_templates', getcwd ]],
          )
    ->exec( '/'.$ARGV[0] );

