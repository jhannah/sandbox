#!/usr/bin/perl

# http://github.com/jhannah/sandbox / graphviz

use strict;
use GraphViz;
use CGI;
my $q = new CGI;

print $q->header;

my $templatedir = "/home/jhannah/src/Omni2/View/Web/Phoenix/root";
my $webdir =      "/home/jhannah/public_html/users/jhannah/graphviz";

my %edges;

open (IN, "find $templatedir | grep -v svn | xargs grep INCLUDE |");
while (<IN>) {
   my ($file, $include) = (/(.*?):.*INCLUDE[ '"]+([\w\._\/]+)/i);
   $file =~ s/$templatedir\///;
   $include =~ s/[';]//g;
   next unless ($file && $include);
   # print "$file -> $include\n";
   $edges{$file}{$include} = 1;
}
close IN;

my $html = <<EOT;
<h1>Phoenix templates<br>
<code><font size=2>$HeadURL<br>
$Id</font></code></h1>

<table>
<tr><td>
<font size=2><code>
EOT

foreach my $node (sort keys %edges) {
   $html .= "<nobr><a href='?node=$node'>$node</a></nobr><br>\n";
}

$html .= <<EOT;
</td>
<td valign='top'><img src='out.png'></td>
</tr>
</table>
EOT

my $once_only = 0;
my $start_with = $q->param('node') || 'rr/RR.tt';
my $g = GraphViz->new();
$g->add_node($start_with, fontname => 'Courier', fontsize => 9, shape => 'box');
add_children($start_with);

open (PNG, ">out.png");
print PNG $g->as_png;
close PNG;

print $html;

# ----------
# END MAIN
# ----------

sub add_children {
   my ($node) = @_;
   foreach my $child (keys %{$edges{$node}}) {
      if ($child =~ /display_template/) {
         # EVERYTHING includes display_template, which is just annoying in flow charts.
         next if ($once_only);
         $child ="$child\n(shown only once)";
         $g->add_node($child, fontname => 'Courier', fontsize => 9, shape => 'box');
         $g->add_edge($node => $child);
         $once_only++;
         next;
      }
      $g->add_node($child, fontname => 'Courier', fontsize => 9, shape => 'box');
      $g->add_edge($node => $child);
      add_children($child);
   }
}


