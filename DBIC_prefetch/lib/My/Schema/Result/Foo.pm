package My::Schema::Result::Foo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

My::Schema::Result::Foo

=cut

__PACKAGE__->table("foo");

=head1 ACCESSORS

=head2 id

  data_type: 'int'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("id", { data_type => "int", is_nullable => 0 });
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 bars

Type: has_many

Related object: L<My::Schema::Result::Bar>

=cut

__PACKAGE__->has_many(
  "bars",
  "My::Schema::Result::Bar",
  { "foreign.foo_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 11:49:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cAhe8rdrSS8LcCVOZ8UA2A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
