use Template;

my $config = {};
my $template = Template->new($config);
my $vars = {};
my $input = 'j.tt';
$template->process($input, $vars)
    || die $template->error();


