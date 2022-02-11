package BorderStyleRole::Source::ASCIIArt;

use strict;
use 5.010001;
use Role::Tiny;
use Role::Tiny::With;
with 'BorderStyleRole::Source::Hash';

# AUTHORITY
# DATE
# DIST
# VERSION

# offsets after newlines are removed
#    012345678901234567
#    ┌───────┬───┬───┐'
#+ 18│ ..... │ . │ . │'
#+ 36│ ..... ├───┼───┤'
#+ 54│ ..... │ . │ . │'
#+ 72│ ..... ├───┴───┤'
#+ 90│ ..... │ ..... │'
#+108├───┬───┤ ..... │'
#+126│ . │ . │ ..... │'
#+144└───┴───┴───────┘'

around get_border_char => sub {
    my $orig = shift;

    #my ($self, %ags) = @_;
    my $self = $_[0];

    #use DD; dd {@_[1.. $#_]};

    # initialize %CHARS from $PICTURE
    {
        no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict

        my $picture = ${"$self->{orig_class}::PICTURE"};
        last unless defined $picture;

        my $chars = \%{"$self->{orig_class}::CHARS"};
        last if keys %$chars; # already initialized

        #say "D1";
        $picture =~ s/\R//g;
        $chars->{rd} = substr($picture,      0, 1);
        $chars->{h}  = substr($picture,      1, 1);
        $chars->{hd} = substr($picture,      8, 1);
        $chars->{ld} = substr($picture,     16, 1);
        $chars->{v}  = substr($picture,  18+ 0, 1);
        $chars->{rv} = substr($picture,  36+ 8, 1);
        $chars->{hv} = substr($picture,  36+12, 1);
        $chars->{lv} = substr($picture,  36+16, 1);
        $chars->{hu} = substr($picture,  72+12, 1);
        $chars->{ru} = substr($picture, 144+ 0, 1);
        $chars->{lu} = substr($picture, 144+16, 1);
        #no strict 'refs'; use DDC; dd \%{"$self->{orig_class}::CHARS"};
    }

    # initialize @MULTI_CHARS from @PICTURES
    {
        no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict

        my $pictures = \@{"$self->{orig_class}::PICTURES"};
        last unless @$pictures;

        my $multi_chars = \@{"$self->{orig_class}::MULTI_CHARS"};
        last if @$multi_chars; # already initialized

        #say "D2";
        for my $entry (@$pictures) {
            my $chars = {};
            my $picture = $entry->{picture};
            $picture =~ s/\R//g;
            $chars->{rd} = substr($picture,      0, 1);
            $chars->{h}  = substr($picture,      1, 1);
            $chars->{hd} = substr($picture,      8, 1);
            $chars->{ld} = substr($picture,     16, 1);
            $chars->{v}  = substr($picture,  18+ 0, 1);
            $chars->{rv} = substr($picture,  36+ 8, 1);
            $chars->{hv} = substr($picture,  36+12, 1);
            $chars->{lv} = substr($picture,  36+16, 1);
            $chars->{hu} = substr($picture,  72+12, 1);
            $chars->{ru} = substr($picture, 144+ 0, 1);
            $chars->{lu} = substr($picture, 144+16, 1);

            push @$multi_chars, {
                %$entry,
                chars => $chars,
            };
        }
        #no strict 'refs'; use DDC; dd \@{"$self->{orig_class}::MULTI_CHARS"};
    } # init @MULTI_CHARS

    # pass
    $orig->(@_);
};

1;
# ABSTRACT: Get border characters from ASCII art

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 package BorderStyle::YourStyle;
 use strict;
 use warnings;
 use utf8;
 use Role::Tiny::With;
 with 'BorderStyleRole::Source::ASCIIArt';

 our $PICTURE = <<'_';
 ┌───────┬───┬───┐'
 │ ..... │ . │ . │'
 │ ..... ├───┼───┤'
 │ ..... │ . │ . │'
 │ ..... ├───┴───┤'
 │ ..... │ ..... │'
 ├───┬───┤ ..... │'
 │ . │ . │ ..... │'
 └───┴───┴───────┘'
 _

 our %BORDER = (
     v => 3,
     summary => 'Summary of your style',
     utf8 => 1,
 );
 1;


=head1 DESCRIPTION

To define border characters, you declare C<$PICTURE> package variable in your
border style class, using a specific ASCII art as shown in the Synopsis. You
then modify the border characters (the lines, not the spaces and the dots)
according to your actual style. This is a convenient way to define border styles
instead of declaring the characters specifically using a hash. Note that empty
border characters are not supported by this role.

For more complex border styles, you define C<@PICTURES> instead, with each
element being a hash:

 # this style is single bold line for header rows, single line for data rows.
 our @PICTURES = (
     {
         # imagine every line is a header-row separator line (theoretically, the
         # top and bottom lines won't ever be used as separator though)
         for_header_data_separator => 1,
         picture => <<'_',
 ┍━━━━━━━┯━━━┯━━━┑'
 ╿ ..... ╿ , ╿ . ╿'
 ╿ ..... ┡━━━╇━━━┫'
 ╿ ..... ╿ . ╿ . ╿'
 ╿ ..... ┡━━━┻━━━┫'
 ╿ ..... ╿ ..... ╿'
 ┡━━━┯━━━┩ ..... ╿'
 ╿ . ╿ . ╿ ..... ╿'
 ┗━━━┻━━━┻━━━━━━━┛'
 _
     },
     {
         for_header_row => 1,
         picture => <<'_',
 ┏━━━━━━━┳━━━┳━━━┓'
 ┃ ..... ┃ , ┃ . ┃'
 ┃ ..... ┣━━━╋━━━┫'
 ┃ ..... ┃ . ┃ . ┃'
 ┃ ..... ┣━━━┻━━━┫'
 ┃ ..... ┃ ..... ┃'
 ┣━━━┳━━━┫ ..... ┃'
 ┃ . ┃ . ┃ ..... ┃'
 ┗━━━┻━━━┻━━━━━━━┛'
 _
     },
     {
         picture => <<'_',
 ┌───────┬───┬───┐'
 │ ..... │ . │ . │'
 │ ..... ├───┼───┤'
 │ ..... │ . │ . │'
 │ ..... ├───┴───┤'
 │ ..... │ ..... │'
 ├───┬───┤ ..... │'
 │ . │ . │ ..... │'
 └───┴───┴───────┘'
 _
     },
 );

Internally, some characters from the ASCII art will be taken and put into
C<%CHARS> or C<@MULTI_CHARS> and this role's C<get_border_char()> will pass to
L<BorderStyleRole::Source::Hash>'s.


=head1 SEE ALSO

L<BorderStyleRole::Source::Hash>

=cut
