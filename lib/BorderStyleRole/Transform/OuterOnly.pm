package BorderStyleRole::Transform::OuterOnly;

use strict;
use 5.010001;
use Role::Tiny;

# AUTHORITY
# DATE
# DIST
# VERSION

around get_border_char => sub {
    my $orig = shift;
    my ($self, %args) = @_;

    my $char = $args{char} or die "Please specify 'char'";
    if ($char =~ /_[i]\z/) {
        return '';
    } else {
        return $orig->(@_);
    }
};

1;
# ABSTRACT: Strip inner border characters

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 package BorderStyle::MyStyle;
 use Role::Tiny::With;
 with 'BorderStyle::OtherStyle';
 with 'BorderStyleRole::Transform::OuterOnly';

 ...
 1;


=head1 DESCRIPTION

This role modifies C<get_border_char()> to return empty string (C<''>) when
requested border character is one of the inner borders (C</_[i]$>>). Otherwise,
it passes control to the original routine.


=head1 MODIFIED METHODS

=head2 get_border_char


=head1 SEE ALSO

L<BorderStyleRole::Transform::InnerOnly>

=cut
