package BorderStyle::Test::Labeled;

use strict;
use utf8;
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

our @MULTI_CHARS = (
    {
        for_header_data_separator => 1,
        chars => {
            h_b => 'Ȧ',
            h_i => 'Ḃ',
            h_t => 'Ċ',
            hd_i => 'Ḋ',
            hd_t => 'Ė',
            hu_b => 'Ḟ',
            hu_i => 'Ġ',
            hv_i => 'Ḣ',
            ld_t => 'İ',
            lu_b => 'Ĵ',
            lv_i => 'Ḱ',
            lv_r => 'Ĺ',
            rd_t => 'Ṁ',
            ru_b => 'Ṅ',
            rv_i => 'Ȯ',
            rv_l => 'Ṗ',
            v_i => 'Ꝙ',
            v_l => 'Ṙ',
            v_r => 'Ṡ',
        },
    },
    {
        for_header_row => 1,
        chars => {
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
        },
    },
    {
        chars => {
            h_b => 'a',
            h_i => 'b',
            h_t => 'c',
            hd_i => 'd',
            hd_t => 'e',
            hu_b => 'f',
            hu_i => 'g',
            hv_i => 'h',
            ld_t => 'i',
            lu_b => 'j',
            lv_i => 'k',
            lv_r => 'l',
            rd_t => 'm',
            ru_b => 'n',
            rv_i => 'o',
            rv_l => 'p',
            v_i => 'q',
            v_l => 'r',
            v_r => 's',
        },
    },
);

1;
# ABSTRACT:

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This border style uses a different label character for each border character.

For header row:

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

For header-data separator:

 h_b => 'Ȧ',
 h_i => 'Ḃ',
 h_t => 'Ċ',
 hd_i => 'Ḋ',
 hd_t => 'Ė',
 hu_b => 'Ḟ',
 hu_i => 'Ġ',
 hv_i => 'Ḣ',
 ld_t => 'İ',
 lu_b => 'Ĵ',
 lv_i => 'Ḱ',
 lv_r => 'Ĺ',
 rd_t => 'Ṁ',
 ru_b => 'Ṅ',
 rv_i => 'Ȯ',
 rv_l => 'Ṗ',
 v_i => 'Ꝙ',
 v_l => 'Ṙ',
 v_r => 'Ṡ',

For data row:

 h_b => 'a',
 h_i => 'b',
 h_t => 'c',
 hd_i => 'd',
 hd_t => 'e',
 hu_b => 'f',
 hu_i => 'g',
 hv_i => 'h',
 ld_t => 'i',
 lu_b => 'j',
 lv_i => 'k',
 lv_r => 'l',
 rd_t => 'm',
 ru_b => 'n',
 rv_i => 'o',
 rv_l => 'p',
 v_i => 'q',
 v_l => 'r',
 v_r => 's',
