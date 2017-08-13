eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}'
    & eval 'exec perl -S $0 $argv:q'
    if 0;

# -*- perl -*-

use Env (DDS_ROOT);
use lib "$DDS_ROOT/bin";
use Env (ACE_ROOT);
use lib "$ACE_ROOT/bin";
use PerlDDS::Run_Test;

$status = 0;
my $test = new PerlDDS::TestFramework();
my $publisher_running_sec=150;
$test->{add_pending_timeout} = 0;
$test->enable_console_logging();


$pub_opts = "-ORBDebugLevel 1 -ORBLogFile publisher.log -DCPSDebugLevel 10";
$sub_opts = "-DCPSTransportDebugLevel 6 -ORBDebugLevel 1 -ORBLogFile subscriber.log -DCPSDebugLevel 10";


PerlDDS::add_lib_path("./model");

$test->setup_discovery();

$test->process("subscriber", "subscriber", " $sub_opts");
$test->process("publisher", "publisher", " $pub_opts");

$test->start_process("publisher");
$test->start_process("subscriber");

my $status = $test->finish($publisher_running_sec, "publisher");

exit $status;
