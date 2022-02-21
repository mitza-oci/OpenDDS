eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}'
     & eval 'exec perl -S $0 $argv:q'
     if 0;

# -*- perl -*-

use Env qw(ACE_ROOT DDS_ROOT);
use lib "$DDS_ROOT/bin";
use lib "$ACE_ROOT/bin";
use PerlDDS::Run_Test;
use PerlDDS::Process_Java;
use strict;

my $status = 0;
my $opts = '-DCPSConfigFile rtps.ini';

PerlACE::add_lib_path('IDL');

my $PUB = PerlDDS::create_process('Cxx/ExamplePublisher', $opts);
my $SUB = new PerlDDS::Process_Java('ExampleSubscriber', $opts,
                                    ['IDL/Service_IDL.jar', 'Java/classes'],
                                    '');

print $PUB->CommandLine() . "\n";
$PUB->Spawn();

print $SUB->CommandLine() . "\n";
$SUB->Spawn();

my $PublisherResult = $PUB->WaitKill(300);
if ($PublisherResult != 0) {
    print STDERR "ERROR: publisher returned $PublisherResult\n";
    $status = 1;
}

my $SubscriberResult = $SUB->WaitKill(30);
if ($SubscriberResult != 0) {
    print STDERR "ERROR: subscriber returned $SubscriberResult\n";
    $status = 1;
}

if ($status == 0) {
    print "test PASSED.\n";
} else {
    print STDERR "test FAILED.\n";
}

exit $status;
