package BorderStyleRole::Transform::InnerOnly;

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
    if ($char =~ /_[tblr]\z/) {
        return '';
    } else {
        return $orig->(@_);
    }
};

1;
# ABSTRACT: Strip outer border characters

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 package BorderStyle::MyStyle;
 use Role::Tiny::With;
 with 'BorderStyle::OtherStyle';
 with 'BorderStyleRole::Transform::InnerOnly';

 ...
 1;


=head1 DESCRIPTION

This role modifies C<get_border_char()> to return empty string (C<''>) when
requested border character is one of the outer borders (C</_[tblr]$>>).
Otherwise, it passes to the original routine.


=head1 MODIFIED METHODS

=head2 get_border_char


=head1 SEE ALSO

L<BorderStyleRole::Transform::OuterOnly>

=cut
