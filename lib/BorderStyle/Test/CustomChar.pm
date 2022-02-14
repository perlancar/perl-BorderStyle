package BorderStyle::Test::CustomChar;

use strict;
use warnings;

use Role::Tiny::With;
with 'BorderStyleRole::Spec::Basic';

# AUTHORITY
# DATE
# DIST
# VERSION

our %BORDER = (
    v => 3,
    summary => 'A border style that uses a single custom character',
    args => {
        character => {
            schema => 'str*',
            req => 1,
        },
    },
    examples => [
        {
            summary => "Use x as the border character",
            args => {character=>"x"},
        },
    ],
);

sub get_border_char {
    my ($self, %args) = @_;
    my $repeat = $args{repeat} // 1;

    $self->{args}{character} x $repeat;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(.+)$
