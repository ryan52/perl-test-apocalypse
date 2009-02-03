# Declare our package
package Test::Apocalypse::FileChecks;
use strict; use warnings;

# Initialize our version
use vars qw( $VERSION );
$VERSION = '0.03';

# setup our tests and etc
use Test::More;
use Test::File;
use File::Find::Rule;

# our list of files to check
my @files = qw( Changes Build.PL Makefile.PL LICENSE MANIFEST MANIFEST.SKIP README META.yml );

# does our stuff!
sub do_test {
	my @pmfiles = File::Find::Rule->file()->name( '*.pm' )->in( 'lib' );
	plan tests => ( ( scalar @files ) * 4 ) + ( ( scalar @pmfiles ) * 3 ) + 3;

	# check SIGNATURE if it's there
	SKIP: {
		if ( -e 'SIGNATURE' ) {
			file_not_empty_ok( 'SIGNATURE', "file SIGNATURE got data" );
			file_readable_ok( 'SIGNATURE', "file SIGNATURE is readable" );
			file_not_executable_ok( 'SIGNATURE', "file SIGNATURE is not executable" );
		} else {
			skip( 'no SIGNATURE file found', 3 );
		}
	}

	# ensure our basic CPAN dist contains everything we need
	foreach my $f ( @files ) {
		file_exists_ok( $f, "file $f exists" );
		file_not_empty_ok( $f, "file $f got data" );
		file_readable_ok( $f, "file $f is readable" );
		file_not_executable_ok( $f, "file $f is not executable" );
	}

	# check all *.pm files for executable too
	foreach my $f ( @pmfiles ) {
		file_not_empty_ok( $f, "file $f got data" );
		file_readable_ok( $f, "file $f is readable" );
		file_not_executable_ok( $f, "file $f is not executable" );
	}

	return;
}

1;
__END__
=head1 NAME

Test::Apocalypse::FileChecks - Plugin to test for file sanity

=head1 SYNOPSIS

	Please do not use this module directly.

=head1 ABSTRACT

This plugin ensures basic sanity for the files in the dist.

=head1 DESCRIPTION

This plugin ensures basic sanity for the files in the dist.

=head1 EXPORT

None.

=head1 SEE ALSO

L<Test::Apocalypse>

L<Test::File>

=head1 AUTHOR

Apocalypse E<lt>apocal@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Apocalypse

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut