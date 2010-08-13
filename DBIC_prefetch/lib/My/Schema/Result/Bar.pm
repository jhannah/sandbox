package My::Schema::Result::Bar;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

My::Schema::Result::Bar

=cut

__PACKAGE__->table("bar");

=head1 ACCESSORS

=head2 id

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id

Type: belongs_to

Related object: L<My::Schema::Result::Foo>

=cut

__PACKAGE__->belongs_to(
  "id",
  "My::Schema::Result::Foo",
  { bar_id => "id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 11:41:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GpABIOvlGP8eADH7rLW11Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
