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

Border style structure must be put in the C<%BORDER> package variable.

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

 my $str = $bs->get_border_char($name, $n, \%char_args);

Get border character named C<$name>, repeated C<$n> times (defaults to 1).
Per-character arguments can also be passed. Known per-character arguments:
C<rownum> (uint, row number of the table cell, starts from 0), C<colnum> (uint,
column number of the table cell, starts from 0).

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

=item * chars

Required, hash. A mapping of border character names and the actual characters.
Must contain these keys:

 (A) header_down_right
 (B) header_horizontal
 (C) header_down_horizontal
 (D) header_down_left

 '┏━━━━━━━━━━━┳━━━━━┳━━━━━┓'
 '┃ ......... ┃ ... ┃ ... ┃'
 '┃ ......... ┣━━━━━┻━━━━━┫'
 '┃ ......... ┃ ......... ┃'
 '┣━━━━━┳━━━━━┫ ......... ┃'
 '┃ ... ┃ ... ┃ ......... ┃'
 '┗━━━━━┻━━━━━┻━━━━━━━━━━━┛'

=head2 Border style character

A border style character can be a single-character string, or a coderef to allow
border style that is context-sensitive.

If border style character is a coderef, it must return a single-character string
and not another coderef. The coderef will be called with the same arguments
passed to L</get_border_char>.


=head1 HISTORY

=head2 v3

Incompatible change in C<chars> to allow for footer area

=head2 v2

The first version of BorderStyle.

=head2 Border::Style

L<Border::Style> is an older specification, superseded by this document.
