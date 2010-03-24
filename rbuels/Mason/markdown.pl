use Text::Markdown 'markdown';

local $/ = undef;
open my $in, "<", $ARGV[0];
my $text = <$in>;
my $html = markdown($text);
print $html;


