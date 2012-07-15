#! /usr/bin/perl
use strict;

use BaseScheduler;

my %no_of_emps = (	'mon' => 15,
			'tue' => 15,
			'wed' => 15,
			'thu' => 15,
			'fri' => 15,
			'sat' => 11,
			'sun' => 7,
		);

my %params = ( company_id => '1049',
               team_id => '10'
             );
my $obj = BaseScheduler->new(\%params);
BaseScheduler::create_initial_schedule($obj, $params{company_id}, \%no_of_emps);

