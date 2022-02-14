package BorderStyle::Test::Labeled;

use strict;
use warnings;

use Role::Tiny::With;
with 'BorderStyleRole::Source::Hash';

# AUTHORITY
# DATE
# DIST
# VERSION

our %BORDER = (
    v => 3,
    summary => 'A border style that uses labeled characters',
    utf8 => 1,
);

our %CHARS = (
    h_b => 'A',
    h_i => 'B',
    h_t => 'C',
    hd_i => 'D',
    hd_t => 'E',
    hu_b => 'F',
    hu_i => 'G',
    hv_i => 'H',
    ld_t => 'I',
    lu_b => 'J',
    lv_i => 'K',
    lv_r => 'L',
    rd_t => 'M',
    ru_b => 'N',
    rv_i => 'O',
    rv_l => 'P',
    v_i => 'Q',
    v_l => 'R',
    v_r => 'S',
);

1;
# ABSTRACT:

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This border style uses a different label character for each border character.

    h_b => 'A',
    h_i => 'B',
    h_t => 'C',
    hd_i => 'D',
    hd_t => 'E',
    hu_b => 'F',
    hu_i => 'G',
    hv_i => 'H',
    ld_t => 'I',
    lu_b => 'J',
    lv_i => 'K',
    lv_r => 'L',
    rd_t => 'M',
    ru_b => 'N',
    rv_i => 'O',
    rv_l => 'P',
    v_i => 'Q',
    v_l => 'R',
    v_r => 'S',
