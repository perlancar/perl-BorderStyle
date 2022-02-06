# no code
## no critic: TestingAndDebugging::RequireUseStrict
package BorderStyle;

# AUTHORITY
# DATE
# DIST
# VERSION

1;
# ABSTRACT: Border styles

=encoding utf8

=head1 DESCRIPTION

This document specifies a way to create and use border styles

=head1 SPECIFICATION VERSION

3


=head1 GLOSSARY

=head2 border style class

=head2 border style structure


=head1 SPECIFICATION

=head2 Border style class

Border style class must be put under C<BorderStyle::*>. Application-specific
border styles should be put under C<BorderStyle::MODULE::NAME::*> or
C<BorderStyle::APP::NAME::*>.

Border style class must also provide these methods:

=over

=item * new

Usage:

 my $bs_obj = BorderStyle::NAME->new( [ %style_args ] );

Arguments will depend on the border style class; each border style class can
define what arguments they want to accept.

=item * get_struct

Usage:

 my $bs_struct = BorderStyle::NAME->get_struct;
 my $bs_struct = $bs_obj->get_struct;

Provide a method way of getting the "border style structure". Must also work as
a static method. A client can also access the %BORDER package variable directly.

=item * get_args

Usage:

 my $args = $bs_obj->get_args;

Provide a method way of getting the arguments to the constructor (the style
arguments). The official implementation BorderStyleBase::Constructor stores this
in the 'args' key of the hash object, but the proper way to access the arguments
should be via this method.

=item * get_border_char

Usage:

 my $str = $bs->get_border_char($name [ , $n, \%char_args ]);

Get border character named C<$name>, repeated C<$n> times (defaults to 1). Names
of known border characters are given below (a character label denotes the border
character below it):


 ABBBBBBBBBBBCBBBBBCBBBBBD
 ┏━━━━━━━━━━━┳━━━━━┳━━━━━┓
 E           E     E     E
 ┃ ......... ┃ ... ┃ ... ┃
 E           FBBBBBGBBBBBH
 ┃ ......... ┣━━━━━╋━━━━━┫
 E           FBBBBBIBBBBBH
 ┃ ......... ┣━━━━━┻━━━━━┫
 E           E           E
 ┃ ......... ┃ ......... ┃
 FBBBBBCBBBBBH           E
 ┣━━━━━┳━━━━━┫ ......... ┃
 E     E     E           E
 ┃ ... ┃ ... ┃ ......... ┃
 JBBBBBGBBBBBGBBBBBBBBBBBK
 ┗━━━━━┻━━━━━┻━━━━━━━━━━━┛

     border character name
     ---------------------
 A = right_down
 B = horizontal
 C = horizontal_down
 D = left_down
 E = vertical
 F = right_vertical
 G = horizontal_vertical
 H = left_vertical
 I = horizontal_up
 J = right_up
 K = left_up

Per-character arguments (C<%char_args>) can also be passed. These arguments will
be passed to border character that is coderef, or to be interpreted by the
class' C<get_border_char()> to vary the character. Known per-character
arguments:

=over

=item * rownum

uint, row number of the table cell, starts from 0.

=item * colnum

uint, column number of the table cell, starts from 0.

=item * is_header_header_separator

Bool. True if drawing a separator line between header rows/columns.

=item * is_header_row

Bool. True if drawing a header row.

=item * is_header_column

Bool. True if drawing a header column.

=item * is_header_data_separator

Bool. True if drawing a separator line between the last header row/column and
the first data row/column.

=item * is_data_row

Bool. True if drawing a data row.

=item * is_data_column

Bool. True if drawing a data column.

=item * is_data_footer_separator

Bool. True if drawing a separator line between the last data row/column and the
first footer row/column.

=item * is_footer_row

Bool. True if drawing a footer row.

=item * is_footer_column

Bool. True if drawing a footer column.

=item * is_footer_footer_separator

Bool. True if drawing a separator line between footer rows/columns.

=item * is_inside_cell

Bool. True if drawing an inside cell. For example, a border style might not draw
any border lines for the inside cells (the lower letter borders are "inside").

 ABBBBBBBBBBBCBBBBBCBBBBBD
 ┏━━━━━━━━━━━┳━━━━━┳━━━━━┓
 E           e     e     E
 ┃ ......... ┃ ... ┃ ... ┃
 E           fbbbbbgbbbbbH
 ┃ ......... ┣━━━━━┻━━━━━┫
 E           e           E
 ┃ ......... ┃ ......... ┃
 Fbbbbbcbbbbbh           E
 ┣━━━━━┳━━━━━┫ ......... ┃
 E     e     e           E
 ┃ ... ┃ ... ┃ ......... ┃
 IBBBBBGBBBBBGBBBBBBBBBBBJ
 ┗━━━━━┻━━━━━┻━━━━━━━━━━━┛

=back

=head2 Border style structure

Border style structure is a L<DefHash> containing these keys:

=over

=item * v

Float, from DefHash, must be set to 2 (this specification version)

=item * name

From DefHash.

=item * summary

From DefHash.

=item * utf8

Bool, must be set to true if the style uses non-ASCII UTF8 border character(s).

Cannot be mixed with L</box_chars>.

=item * box_chars

Bool, must be set to true if the style uses box-drawing character. When using
box-drawing character, the characters in L</chars> property must be specified
using the VT100-style escape sequence without the prefix. For example, the
top-left single border character must be specified as "l". For more details on
box-drawing character, including the list of escape sequneces, see
L<https://en.wikipedia.org/wiki/Box-drawing_character>.

Box-drawing characters must not be mixed with other characters (ASCII or UTF8).

=item * args

A hash of argument names and specifications (each specification a L<DefHash>) to
specify which arguments a border style accept. This is similar to how
L<Rinci::function> specifies function arguments. An argument specification can
contain these properties: C<summary>, C<description>, C<schema>, C<req>,
C<default>.

=back

Border style structure must be put in the C<%BORDER> package variable.

=head2 Border style character

A border style character can be a single-character string, or a coderef to allow
border style that is context-sensitive.

If border style character is a coderef, it must return a single-character string
and not another coderef. The coderef will be called with the same arguments
passed to L</get_border_char>.


=head1 HISTORY

=head2 v3

Incompatible change. Remove C<chars> in border style structure and abstract it
through C<get_border_char()> to be more flexible, e.g. to allow for footer area,
vertical header (header columns), and so on. Replace the positional C<x, y>
arguments with character name and attributes, to be more flexible and readable.

=head2 v2

The first version of BorderStyle.

=head2 Border::Style

L<Border::Style> is an older specification, superseded by this document.
