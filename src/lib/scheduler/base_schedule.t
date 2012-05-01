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

BaseScheduler::create_initial_schedule(undef, \%no_of_emps);

