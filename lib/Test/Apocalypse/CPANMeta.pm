# Declare our package
package Test::Apocalypse::CPANMeta;
use strict; use warnings;

# Initialize our version
use vars qw( $VERSION );
$VERSION = '0.06';

use Test::More;

sub do_test {
	my %MODULES = (
		'Test::CPAN::Meta'	=> '0.13',
	);

	while (my ($module, $version) = each %MODULES) {
		eval "use $module $version";	## no critic ( ProhibitStringyEval )
		next unless $@;

		if ( $ENV{RELEASE_TESTING} ) {
			die 'Could not load release-testing module ' . $module . " -> $@";
		} else {
			plan skip_all => $module . ' not available for testing';
		}
	}

	# Run the test!
	meta_yaml_ok();

	return;
}

1;
__END__
=head1 NAME

Test::Apocalypse::CPANMeta - Plugin for Test::CPAN::Meta

=head1 SYNOPSIS

	# Please do not use this module directly.

=head1 ABSTRACT

Encapsulates Test::CPAN::Meta functionality.

=head1 DESCRIPTION

Encapsulates Test::CPAN::Meta functionality.

=head1 SEE ALSO

L<Test::Apocalypse>

L<Test::CPAN::Meta>

=head1 AUTHOR

Apocalypse E<lt>apocal@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Apocalypse

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
