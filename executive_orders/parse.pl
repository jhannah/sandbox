#! env perl

use 5.40.0;
use Text::CSV;

my $csv = Text::CSV->new ({ binary => 1, auto_diag => 1 });
# https://www.federalregister.gov/presidential-documents/executive-orders
# All Executive Orders Since 1937 CSV/Excel
open my $fh, "<:encoding(utf8)", "eos.csv" or die $!;
while (my $row = $csv->getline($fh)) {
  # citation,document_number,end_page,html_url,pdf_url,
  # type,subtype,publication_date,signing_date,start_page,
  # title,disposition_notes,executive_order_number,not_received_for_publication
  my $disp = $row->[11];
  $disp =~ s/[\r\n]+/ /g;
  printf("%s %s %s\n", $row->[8], $row->[12], $disp);

  my @revoked;
  my ($ignore, $revoked) = ($disp =~ /Revokes( in part)?: ([^:]+)/);
  if ($revoked) {
    @revoked = ($revoked =~ /EO (\d+)/g);
    printf("  Revokes: %s\n", (join "|", @revoked));
  }

  my @rescinded;
  my ($rescinds) = ($disp =~ /Rescinds: ([^:]+)/);
  if ($rescinds) {
    my @rescinded = ($rescinds =~ /EO (\d+)/g);
    printf("  Rescinds: %s\n", (join "|", @rescinded));
  }

  # Amends:
  # Supersedes:
}


