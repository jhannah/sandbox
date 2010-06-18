package ManySites::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    INTERPOLATE => 1,
);

=head1 NAME

ManySites::View::TT - TT View for ManySites

=head1 DESCRIPTION

TT View for ManySites.

=head1 SEE ALSO

L<ManySites>

=head1 AUTHOR

Jay Hannah

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
