use 5.020;
use Test::More;
use Test::Deep;
use Test::Exception;
use Test::Fatal;
use lib 'blib';
use lib 'blib/arch';
use lib 'lib';
use CSGame::Logger;
use Time::HiRes qw |time|;

ok my $obj = CSGame::Logger->new(), 'create';

my $is_opened = 0;
#$obj->open('test_file.log', undef);
$obj->open('test_file.log', sub{
	       my $self = shift;
	       my $err  = shift;

	       die $err if $err;
	       diag "OPEN CALLBACK";
	       $is_opened = 1;
#	       $self->loop_stop();
	   });

note explain $obj;
note "GO TO OPEN";
$obj->loop_run();
note "OPENED " . $is_opened;
$obj->print("TEST", sub { note "Write CALLBACK" });
$obj->loop_run();

my $i = 0;
diag "PID: $$";
my $msg = "--LINE 1c++ -c  -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/Event.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/catch/test.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/panda/lib.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/XS.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/Export.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/URI.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/Range.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/XS.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/catch/test.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/panda/lib.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/Lib.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/catch/test.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/CPP/panda/lib.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/XS.x/i -I/home/v.melnichenko/pirates/meia/var/lib/x86_64-linux/Panda/Export.x/i -g -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 -o src/pirates-log/log.o -std=c++11 -O2 -pipe -fno-strict-aliasing   -DVERSION=\0.1\ -DXS_VERSION=\0.1\ -fPIC -I/usr/local/perl5.26.1/lib/5.26.1/x86_64-linux/CORE   src/pirates-log/log.cc\n";
my $total = 0;
while ( $i++ < 100000 ) {
    my $start_time = time();
    $obj->print( $msg, sub{shift->loop_stop()} );
    $total += ( time() - $start_time);
    $obj->loop_run();

#    sleep 2;
}

diag "Time: " . ( $total * 1000 ) . " ms";

open my $FH, ">", 'test_file_1.log';
$i = 0;
my $start_time = time();
while ( $i++ < 100000 ) {
    print $FH $msg;
}
diag "Time: " . ( ( time() - $start_time) * 1000 ) . " ms";

close $FH;
# ok my $obj = CSGame::Logger->new($FH), 'create';

=cut

done_testing();
