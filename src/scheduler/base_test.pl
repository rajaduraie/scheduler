#Test file for BaseSchedule

use strict;
use Test::Simple tests=>3;

use BaseSchedule;

my $obj = BaseSchedule->new();

ok (defined($obj), 'new() works');

die "Cannot create BaseSchedule object" unless($obj);

my $db = $obj->get_db();

ok (defined($db), 'DB object created');

my $logger = $obj->get_logger();

ok (defined($logger), 'Logger created');

$logger->error("The tests have succeeded ");
