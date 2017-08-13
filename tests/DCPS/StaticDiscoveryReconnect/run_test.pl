eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}'
     & eval 'exec perl -S $0 $argv:q'
     if 0;

# -*- perl -*-

use lib "$ENV{ACE_ROOT}/bin";
use lib "$ENV{DDS_ROOT}/bin";
use PerlDDS::Run_Test;
use strict;
use warnings;

my $result = 0;
my $scenario = shift;
$scenario |= "";

if ($scenario ne "reader_first")
{
    my $test = new PerlDDS::TestFramework();
    $test->enable_console_logging();
    $test->{wait_after_first_proc} = 40;
    $test->{dcps_debug_level} = 10;

    $test->process("writer1", 'StaticDiscoveryTest', "-DCPSConfigFile config.ini -ORBLogFile writer1.log -writer");
    $test->start_process("writer1");

    $test->process("reader1", 'StaticDiscoveryTest', "-DCPSConfigFile config.ini -ORBLogFile reader1.log -reader -toggle");
    $test->start_process("reader1");

    my $res = $test->finish(40);
    if ($res != 0) {
        print STDERR "ERROR: test returned $res\n";
        $result += $res;
    }
}

if ($scenario ne "writer_first")
{
    my $test = new PerlDDS::TestFramework();
    $test->enable_console_logging();
    $test->{wait_after_first_proc} = 40;
    $test->{dcps_debug_level} = 10;

    $test->process("reader2", 'StaticDiscoveryTest', "-DCPSConfigFile config.ini -ORBLogFile reader2.log -reader");
    $test->start_process("reader2");

    $test->process("writer2", 'StaticDiscoveryTest', "-DCPSConfigFile config.ini -ORBLogFile writer2.log -writer -toggle");
    $test->start_process("writer2");

    my $res = $test->finish(40);
    if ($res != 0) {
        print STDERR "ERROR: test returned $res\n";
        $result += $res;
    }
}

exit $result;
