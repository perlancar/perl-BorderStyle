package BorderStyleRole::Source::Hash;

use strict;
use 5.010001;
use Role::Tiny;
use Role::Tiny::With;
with 'BorderStyleRole::Spec::Basic';

# AUTHORITY
# DATE
# DIST
# VERSION

sub get_border_char {
    my ($self, %args) = @_;

    my $char = $args{char} or die "Please specify 'char'";
    my $repeat = $args{repeat} // 1;

    no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict

    #use DD; dd \%args;

    my $_char;

    # @MULTI_CHARS
    {
        last unless @{"$self->{orig_class}::MULTI_CHARS"};
        my $i = -1;
      ENTRY:
        for my $entry (@{"$self->{orig_class}::MULTI_CHARS"}) {
            $i++;
            #use DD; print "entry: "; dd $entry;
            for my $criteria_key (keys %$entry) {
                next unless $criteria_key =~ /^for_/;
                #print "D:criteria_key=$criteria_key ";
                next ENTRY unless defined $args{$criteria_key};
                next ENTRY unless $entry->{$criteria_key} == $args{$criteria_key};
            }
            #print "D:entry[$i] matches criteria\n";
            # the entry matches the criteria
            die "Unknown (in \$MULTI_CHARS[$i]) border character requested: '$char'"
                unless defined ($_char = $entry->{chars}{$char});
            goto PROCESS;
        } # for $entry
    }

    # %CHARS
    {
        my $chars = \%{"$self->{orig_class}::CHARS"};
        die "Unknown (in \%CHARS) border character requested: '$char'"
            unless defined ($_char = $chars->{$char});
        goto PROCESS;
    }

  PROCESS:
    # process coderef border char
    if (ref $_char eq 'CODE') {
        return $_char->(%args);
    } else {
        return $_char x $repeat;
    }
}

1;
# ABSTRACT: Get border characters from %CHARS (or @MULTI_CHARS) package variable

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS



=head1 DESCRIPTION

=head1 SEE ALSO

Other C<BorderStyleRole::Source::*> roles.

=cut
