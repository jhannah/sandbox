use Class::Date;
use 5.10.0;

my $reldate = new Class::Date::Rel "561s";
say "In minutes: " . $reldate->min;
say "In seconds: " . $reldate->sec;

my $seconds_only = $reldate - (int($reldate->min) * 60 . 'm');  # subtract minutes away
say "Seconds only: $seconds_only";
printf("%d minutes %d seconds\n", int($reldate / 60), $seconds_only);


