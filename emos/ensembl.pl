#!/usr/bin/perl

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

my $slice_adaptor = $registry->get_adaptor( 'Human', 'Core', 'Slice' );

# This works:
$slice = $slice_adaptor->fetch_by_region( 'chromosome', '20', 100000, 101000 );
print $slice->seq;

# These don't:
#$slice = $slice_adaptor->fetch_by_region( 'supercontig', 'NT_025741.15', 100, 200 );
# $slice = $slice_adaptor->fetch_by_region( 'supercontig', 'NT_025741');
# print $slice->seq;


