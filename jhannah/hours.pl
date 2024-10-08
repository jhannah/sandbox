use 5.26.0;

my $weeks_off = 4;
my $holidays = 11;
# 40 hours per week. Minus holidays.
my $quota_per_month = (40 * (52 - $weeks_off) - (8 * $holidays)) / 12;
say "Per year: $weeks_off weeks off (PTO + sick) + $holidays holidays";
printf("Monthly quota: %.1f\n", $quota_per_month);
say "year-month hours_worked hours_banked";

my $bank;
while (<DATA>) {
  chomp;
  my ($ym, $hours_worked) = split /\t/;
  $bank = $bank - $quota_per_month + $hours_worked;
  printf("%s %7s %7s\n", $ym, $hours_worked, sprintf("%.0f", $bank));
}

# https://docs.google.com/spreadsheets/d/19YVGu_-Ga8Uyqgvo6EMzSses3yadqPj7JC8n8pPGMIs/edit#gid=0
# year-month hours_worked
__DATA__
2018-01	197
2018-02	162
2018-03	187
2018-04	156
2018-05	138
2018-06	155
2018-07	164
2018-08	183
2018-09	138
2018-10	186
2018-11	163
2018-12	147
2019-01	165
2019-02	155
2019-03	90
2019-04	170
2019-05	168
2019-06	158
2019-07	181
2019-08	194
2019-09	73
2019-10	205
2019-11	159
2019-12	137
2020-01	171
2020-02	145
2020-03	144
2020-04	176.5
2020-05	164.5
2020-06	168
2020-07	176
2020-08	158
2020-09	155.5
2020-10	163
2020-11	151
2020-12	158
2021-01	149.5
2021-02	148.5
2021-03	151
2021-04	163
2021-05	156
2021-06	182
2021-07	85.5
2021-08	142.5
2021-09	165
2021-10	158
2021-11	161
2021-12	171.5
2022-01	159.5
2022-02	157.5
2022-03	189
2022-04	170.5
2022-05	149.5
2022-06	103
2022-07	153.5
2022-08	163
2022-09	165.5
2022-10	159
2022-11	160
2022-12	154
