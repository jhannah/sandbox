use File::Find::Rule;
my @dirs = glob "Pump It Up P*/*";
my @files = File::Find::Rule->file()->name('*.sm')->in(@dirs);
foreach my $file (@files)
{
  print $file . "\n";
}
exit;

