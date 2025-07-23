eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}'
    & eval 'exec perl -S $0 $argv:q'
    if 0;

# -*- perl -*-

use Env (DDS_ROOT);
use lib "$DDS_ROOT/bin";
use Env (ACE_ROOT);
use lib "$ACE_ROOT/bin";
use PerlDDS::Run_Test;
use File::Path;
use strict;

my $orb_debug = '-ORBDebugLevel 10 -ORBVerboseLogging 1';

my $test = new PerlDDS::TestFramework();
$test->{'dcps_debug_level'} = $test->{'dcps_transport_debug_level'} = 10;
$test->setup_discovery($orb_debug);

$test->process('subscriber', 'subscriber', $orb_debug);
$test->process('publisher', 'publisher', $orb_debug);

rmtree('./DCS');

$test->start_process('publisher');
$test->start_process('subscriber');

exit($test->finish(60));
