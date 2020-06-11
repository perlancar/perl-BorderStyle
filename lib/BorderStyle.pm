package BorderStyle;

# AUTHORITY
# DATE
# DIST
# VERSION

1;
# ABSTRACT: Border styles

=head1 DESCRIPTION

This document specifies a way to create and use border styles

=hea1 SPECIFICATION VERSION

2


=head1 GLOSSARY

=head2 border style class

=head2 border style structure


=head1 SPECIFICATION

=head2 Border style class

Border style class must be put under C<BorderStyle::*> or, in the case of
application-specific border styles, C<APP::NAME::BorderStyle::*> where
C<APP::NAME> is an application's namespace.

Border style structure must be put in the C<%BORDER> package variable.

Border style class must also provide these methods:

=over

=item * new

Usage:

 my $bs_obj = BorderStyle::NAME->new( [ %args ] );

Arguments will depend on the border style class (see L</args>).

=item * get_struct

Usage:

 my $bs_struct = BorderStyle::NAME->get_struct;
 my $bs_struct = $bs_obj->get_struct;

Provide a method way of getting the "border style structure". A client can also
access the %BORDER package variable directly.

=item * get_args

Usage:

 my $args = $bs_obj->get_args;

Provide a method way of getting the arguments to the constructor. The official
implementation BorderStyleBase::Constructor stores this in the 'args' key of the
hash object, but the proper way to access the arguments should be via this
method.

=item * get_border_char

Usage:

 my $str = $bs->get_border_char($y, $x, $n, \%args);

Get border character at a particular C<$y> and C<$x> position, duplicated C<$n>
times (defaults to 1). Arguments can be passed to border character that is a
coderef.

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

Bool, must be set to true if the border characters are Unicode characters in
UTF8.

=item * chars

An array. Required. Format for the characters in C<chars>:

 [                # y
 #x 0  1  2  3
   [A, b, C, D],  # 0
   [E, F, G],     # 1
   [H, i, J, K],  # 2
   [L, M, N],     # 3
   [O, p, Q, R],  # 4
   [S, t, U, V],  # 5
 ]

When drawing border, below is how the border characters will be used:

 AbbbCbbbD        #0 Top border characters
 E   F   G        #1 Vertical separators for header row
 HiiiJiiiK        #2 Separator between header row and first data row
 L   M   N        #3 Vertical separators for data row
 OpppQpppR        #4 Separator between data rows
 L   M   N        #3
 StttUtttV        #5 Bottom border characters

A character can also be a coderef that will be called with C<< ($self, $y, $x,
$n, \%args) >>. See L</Border style character>.

=head1 Border style character

A border style character can be a single-character string, or a coderef to allow
border style that is context-sensitive.

If border style character is a coderef, it must return a single-character string
and not another coderef. The coderef will be called with the same arguments
passed to L</get_border_char>.


=head1 HISTORY

L<Border::Style> is an older specification, superseded by this document.
