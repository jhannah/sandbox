use strict;
use warnings;
use 5.26.0;
use JSON::XS;
use CSS;
use CSS::Sass;

my $json_text = do {
   open(my $json_fh, "<:encoding(UTF-8)", "input.json") or die $!;
   local $/;
   <$json_fh>
};
# say $json_text;

my $json = JSON::XS->new;
my $json_data = $json->decode($json_text);

my $css = CSS->new($json_data);
$css->read_string(
say $css->output;

my $sass = CSS::Sass->new;
# Manipulate options for compile calls
$sass->options->{source_comments} = 1;
# Call file compilation (may die on errors)
#my $css = $sass->compile_file('styles.scss');
## Add custom function to use inside your Sass code
#sub foobar { CSS::Sass::Value::String->new('blue') }
#$sass->options->{sass_functions}->{'foobar'} = \ &foobar;
# Compile string and get css output and source-map json
# $sass->options->{source_map_file} = 'output.css.map';
#my ($css, $stats) = $sass->compile($css);






