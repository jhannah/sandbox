
use Template;

my $config = {
    WRAPPER => 'wrapper.tt',
};
my $template = Template->new($config);
my $vars = { 
   title => {
      mine => "",
   }
};
my $input = 'q1.tt';

$template->process($input, $vars) || die $template->error();


