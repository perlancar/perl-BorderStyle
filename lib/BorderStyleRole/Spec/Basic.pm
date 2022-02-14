package BorderStyleRole::Spec::Basic;

use strict;
use warnings;

use Role::Tiny;
#use Role::Tiny::With;

# AUTHORITY
# DATE
# DIST
# VERSION

### requires

requires 'get_border_char';

### provides

sub new {
    no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict
    my $class = shift;

    # check that %BORDER exists
    my $bs_hash = \%{"$class\::BORDER"};
    unless (defined $bs_hash->{v}) {
        die "Class $class does not define \%BORDER with 'v' key";
    }
    unless ($bs_hash->{v} == 3) {
        die "\%$class\::BORDER's v is $bs_hash->{v}, I only support v=2";
    }

    # check for known and required arguments
    my %args = @_;
    {
        my $args_spec = $bs_hash->{args};
        last unless $args_spec;
        for my $arg_name (keys %args) {
            die "Unknown argument '$arg_name'" unless $args_spec->{$arg_name};
        }
        for my $arg_name (keys %$args_spec) {
            die "Missing required argument '$arg_name'"
                if $args_spec->{$arg_name}{req} && !exists($args{$arg_name});
            # apply default
            $args{$arg_name} = $args_spec->{$arg_name}{default}
                if !defined($args{$arg_name}) &&
                exists $args_spec->{$arg_name}{default};
        }
    }

    bless {
        args => \%args,

        # we store this because applying roles to object will rebless the object
        # into some other package.
        orig_class => $class,
    }, $class;
}

sub get_struct {
    no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict
    my $self_or_class = shift;
    if (ref $self_or_class) {
        \%{"$self_or_class->{orig_class}::BORDER"};
    } else {
        \%{"$self_or_class\::BORDER"};
    }
}

sub get_args {
    my $self = shift;
    $self->{args};
}

my @role_prefixes = qw(BorderStyleRole);
sub apply_roles {
    my ($obj, @unqualified_roles) = @_;

    my @roles_to_apply;
  ROLE:
    for my $ur (@unqualified_roles) {
      PREFIX:
        for my $prefix (@role_prefixes) {
            my ($mod, $modpm);
            $mod = "$prefix\::$ur";
            ($modpm = "$mod.pm") =~ s!::!/!g;
            eval { require $modpm; 1 };
            unless ($@) {
                #print "D:$mod\n";
                push @roles_to_apply, $mod;
                next ROLE;
            }
        }
        die "Can't find role '$ur' to apply (searched these prefixes: ".
            join(", ", @role_prefixes);
    }

    Role::Tiny->apply_roles_to_object($obj, @roles_to_apply);

    # return something useful
    $obj;
}

1;
# ABSTRACT: Required methods for all BorderStyle::* modules

=head1 DESCRIPTION

L<BorderStyle>::* modules define border styles.


=head1 REQUIRED METHODS

=head2 new

Usage:

 my $bs = BorderStyle::Foo->new([ %args ]);

Constructor. Must accept a pair of argument names and values.

=head2 get_struct

=head2 get_args

=head2 get_border_char


=head1 PROVIDED METHODS

=head2 apply_roles

Usage:

 $obj->apply_roles('R1', 'R2', ...)

Apply roles to object. R1, R2, ... are unqualified role names that will be
searched under C<BorderStyleRole::*> namespace. It's a convenience shortcut for
C<< Role::Tiny->apply_roles_to_object >>.

Return the object.


=head1 SEE ALSO

L<BorderStyle>
