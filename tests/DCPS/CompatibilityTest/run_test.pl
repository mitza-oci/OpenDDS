eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}'
    & eval 'exec perl -S $0 $argv:q'
    if 0;

# -*- perl -*-

use Env (DDS_ROOT);
use lib "$DDS_ROOT/bin";
use Env (ACE_ROOT);
use lib "$ACE_ROOT/bin";
use PerlDDS::Run_Test;
use strict;
use Getopt::Std;

# declare the perl command line flags/options we want to allow
my %options=();
getopts("d:i:", \%options);

my $status = 0;

PerlDDS::add_lib_path('../FooType4');
PerlDDS::add_lib_path('../common');
# single reader with single instances test
my $is_rtps_disc = 0;
my $DCPScfg = "";
my $level = 0;
$level = $options{d} if defined $options{d};

my $conf = $ARGV[0];

if ($ARGV[0] eq "rtps_disc") {
  $DCPScfg = "-DCPSConfigFile " . $ARGV[0] . ".ini ";
  $is_rtps_disc = 1;
  shift;
} elsif ($ARGV[0] eq "rtps_disc_tcp") {
  $DCPScfg = "-DCPSConfigFile " . $ARGV[0] . ".ini ";
  $is_rtps_disc = 1;
  shift;
}

sub run_compatibility_tests {
  return if $status;

  # test multiple cases
  my $compatibility = shift;

  my $pub_durability_kind = shift;
  my $pub_liveliness_kind = shift;
  my $pub_lease_time = shift;
  my $pub_reliability_kind = shift;

  my $sub_durability_kind = shift;
  my $sub_liveliness_kind = shift;
  my $sub_lease_time = shift;
  my $sub_reliability_kind = shift;
  my $testnum = shift;
  print "\n\n"; # Provide some visual relief between test cases.
  print "Test #" . $testnum . "\n";
  print "\n\n"; # Provide some visual relief between test cases.

  my $test = new PerlDDS::TestFramework();
  my $ior_config = "";

  if (! $is_rtps_disc) {
      my $ior_file = "repo$testnum.ior";
      $test->{info_repo}->{file}=$ior_file;
      $test->setup_discovery();
      $ior_config = "-DCPSInfoRepo file://$ior_file";
  }

  my $sub_time = 40;
  my $pub_time = $sub_time;
  my $sub_parameters = "-l $sub_lease_time -x $sub_time -c $compatibility -d $sub_durability_kind -k $sub_liveliness_kind -r $sub_reliability_kind -DCPSDebugLevel $level $ior_config $DCPScfg -";

  $test->process("subscriber_". $conf ."_$testnum", "subscriber", $sub_parameters);

  my $pub_parameters = "-c $compatibility -d $pub_durability_kind -k $pub_liveliness_kind -r $pub_reliability_kind -l $pub_lease_time -x $pub_time -DCPSDebugLevel $level $ior_config $DCPScfg";

  $test->process("publisher_". $conf ."_$testnum", "publisher", "$pub_parameters");

  $test->start_process("subscriber_". $conf ."_$testnum");

  sleep 3;

  $test->start_process("publisher_". $conf ."_$testnum");

  my $result = $test->finish($sub_time + 20);

  if ($result != 0) {
    print STDERR "ERROR: test returned $result \n";
    $status = 1;
  }

}

my $configs = new PerlACE::ConfigList;
my $no_persist = $configs->check_config('DDS_NO_PERSISTENCE_PROFILE');


my @params = (
    ["false","transient"       , "topic"    , "infinite" , "best_effort", "transient_local", "topic"    , "infinite", "reliable"],
    ["true", "transient_local" , "automatic", "5"        , "reliable"   , "transient_local", "automatic", "5"       , "reliable"],
    ["true", "transient_local" , "automatic", "6"        , "reliable"   , "volatile"       , "automatic", "7"       , "best_effort"],
    ["true", "transient_local" , "automatic", "5"        , "reliable"   , "volatile"       , "automatic", "infinite", "best_effort"],
    ["true", "transient_local" , "automatic", "infinite" , "reliable"   , "volatile"       , "automatic", "infinite", "best_effort"],
    ["false", "transient_local", "automatic", "6"        , "reliable"   , "transient_local", "automatic", "5"       , "reliable"],
    ["false", "transient_local", "automatic", "infinite" , "reliable"   , "transient_local", "automatic", "5"       , "reliable"],
    ["false", "transient_local", "automatic", "6"        , "reliable"   , "transient_local", "automatic", "5"       , "reliable"],
    ["false", "transient_local", "automatic", "5"        , "best_effort", "transient_local", "automatic", "5"       , "reliable"],
    ["false", "volatile",        "automatic", "5"        , "reliable"   , "transient_local", "automatic", "5"       , "reliable"]
);


if (defined $options{i})
{
  my $index = $options{i};
  my $args = $params[$index-1];
  run_compatibility_tests(@$args, $index);
}
else
{
  my $index = 1;
  if ($no_persist) {
    shift @params;
    $index++;
  }

  foreach my $row (@params)
  {
    run_compatibility_tests(@$row, $index++);
  }
}
# there are more to test later, but they are currently treated as invalid
# since there are not supported in the code

exit $status;
