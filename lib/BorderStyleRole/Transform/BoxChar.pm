package BorderStyleRole::Transform::BoxChar;

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
    my $res = $orig->(@_);
    return '' unless length $res;
    "\e(0$res\e(B";
};

1;
# ABSTRACT: Emit proper escape code to display box characters

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 package BorderStyle::MyStyle;
 use Role::Tiny::With;
 with 'BorderStyle::OtherStyle';
 with 'BorderStyleRole::Transform::BoxChar';

 ...
 1;


=head1 DESCRIPTION

This role modifies C<get_border_char()> to emit proper escape code to display
box characters.


=head1 MODIFIED METHODS

=head2 get_border_char


=head1 SEE ALSO

=cut
