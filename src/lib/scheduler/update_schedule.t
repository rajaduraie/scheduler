use strict; 
use UpdateSchedule;
use Data::Dumper;

my %params = ( team_id => 1049,
               day => 'sun',
               shft => 2,
             );

my $old_emp = 'E1';
my $new_emp = 'E12';
my $obj = UpdateSchedule->new();
my $new_list = $obj->manual_update(\%params, $new_emp, $old_emp);
print Dumper($new_list);
