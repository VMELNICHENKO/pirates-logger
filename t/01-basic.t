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
my $msg = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?\n";
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
