#!/usr/bin/perl

use Template;

my $config = {
    POST_CHOMP   => 1,               # cleanup whitespace
};
my $template = Template->new($config);
my $vars = {};
my $input = 'go.tt';

$template->process($input, $vars)
    || die $template->error();


