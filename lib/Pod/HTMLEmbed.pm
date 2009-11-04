package Pod::HTMLEmbed;
use Any::Moose;

our $VERSION = '0.01';

use Carp::Clan '^(Mo[ou]se::|Pod::HTMLEmbed(::)?)';
use Pod::Simple::Search;
use Pod::HTMLEmbed::Entry;

has search_dir => (
    is        => 'rw',
    isa       => 'ArrayRef',
    predicate => 'has_search_dir',
);

has url_prefix => (
    is        => 'rw',
    isa       => 'Str',
    predicate => 'has_url_prefix',
);

no Any::Moose;

sub load {
    my ($self, $file) = @_;
    Pod::HTMLEmbed::Entry->new( file => $file, _context => $self );
}

sub find {
    my ($self, $name) = @_;

    my $file;
    my $finder = Pod::Simple::Search->new;

    if ($self->has_search_dir) {
        $finder->inc(0);
        $file = $finder->find( $name, @{ $self->search_dir } );
    }
    else {
        $file = $finder->find( $name );
    }

    unless ($file) {
        my $dirs = join ':', $self->has_search_dir ?
            (@{ $self->search_dir }) : (@INC);

        croak qq[No pod found by name "$name" in $dirs];
    }

    $self->load($file);
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

Pod::HTMLEmbed - 

=head1 SYNOPSIS

Get L<Pod::HTMLEmbed::Entry> object from File:

    my $p   = Pod::HTMLEmbed->new;
    my $pod = $p->load('/path/to/pod.pod');

Or search by name in @INC

    my $p   = Pod::HTMLEmbed->new;
    my $pod = $p->find('Moose');

Or search by name in specified directory

    my $p   = Pod::HTMLEmbed->new( search_dir => ['/path/to/dir'] );
    my $pod = $p->find('Moose');

=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2009 by KAYAC Inc.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
