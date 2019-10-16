package Pirates::Log;
use 5.020;
use strict;
use warnings;

use XSLoader;
#use parent 'Panda::Export';

our $VERSION = '0.1';
#require Panda::XSLoader;
#Panda::XSLoader::bootstrap();
XSLoader::load( 'Pirates::Log', $VERSION );

1;

=head1 NAME

Pirates::Log - XS code for Pirates

=head1 SYNOPSYS

    use Pirates::Log;
    my $obj = Pirates::Log->new;

=cut
