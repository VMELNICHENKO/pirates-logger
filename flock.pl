use Fcntl ':flock'; # import LOCK_* constants
use Time::HiRes qw|usleep|;
while ( 1 ) {
    # open the file for appending
    open (my $fh, '>>', 'test_file.log') or die $!;

    # try to lock the file exclusively, will wait till you get the lock
    flock($fh, LOCK_EX);
usleep 0.1;
    # do something with the file here (print to it in our case)

    # actually you should not unlock the file
    # close the file will unlock it
    close($fh) or warn "Could not close file $!";
}
