package BaseScheduler;

use strict;

use Carp;

use Constants;

use Connection;
use CompanyDB;
use TeamDB;
use DayDB;
use DefaultScheduleDB;

sub new {
  my($class, $params) = @_;
  my $self = {};
  my $connection = Connection->new();
  $self->{db} = $connection;
  my $company_id = $params->{company_id};
  my $team_id = $params->{team_id};
  my $company = CompanyDB->new($connection);
  my $team = TeamDB->new($connection);
  $self->{company} = $company;   
  $self->{team} = $team;
  bless $self, $class;
  return $self;
}

sub create_employee_list {
  my($self, $params) = @_;
  my (%e, %d);
  my @day_sort = sort { $params->{$a} <=> $params->{$b} } keys(%$params);
  my $count = $params->{$day_sort[1]} + $params->{$day_sort[6]};
  my @emps = ();
  for(1..$count) {
    push @emps, 'E'.$_;
  }
  DAY:
  foreach my $day (keys %$params) {
    $d{$day}->{count}=0;
    EMP:  
    foreach my $emp (@emps) {
      next EMP if($e{$emp} == 5);
      $e{$emp}++;
      if($d{$day}->{count} < $params->{$day}) {
        $d{$day}->{$emp} = 1;
        $d{$day}->{count}++;
      } else {
        $e{$emp}--;
        next DAY;
      }
    }
  }

  my @new_emps = sort { $e{$a} <=> $e{$b} } keys %e;

  my %new_days = %d;
  my %new_e = %e;
  my $old = pop(@new_emps);
  my $new = shift(@new_emps);

  EMP:
  while(1){
    if($new_e{$old} == 0) {
      $old = pop(@new_emps);
    }
    if($new_e{$new} == 5) {
      ($new) = shift(@new_emps);
    }
    last EMP if($new_e{$new} == 5) ;
    foreach my $day ('sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri') {
      if($new_days{$day}->{$old} and !$new_days{$day}->{$new}) {
        $new_e{$new}++;
        $new_e{$old}--;
        $new_days{$day}->{$new} = 1;
        $new_days{$day}->{$old} = 0;
        next EMP if(($new_e{$new} == 5) or ($new_e{$old} == 0));
      }
    }
  }
  my %em;
  foreach my $day ('sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri') {
    foreach(@emps) {
      if($new_days{$day}->{$_} == 1) { 
        $em{$_}++;
      }
    }
  }
  return (\%em,\%new_days);
}

sub create_initial_schedule {
  my($self, $team_id, $params) = @_;
  unless($self && $team_id) {
    croak "The Self object and the team id need to be passed";
  }
  my $db = $self->get_db();
  unless($db) {
    croak "Database object not created \n";
  }
  my ($emps, $emp_list) = $self->create_employee_list($params);
  my $default_schedule = DefaultScheduleDB->new($db);
  foreach my $day (keys(%$emp_list)) {
    my $day_hash = $emp_list->{$day};
    my $day_list = '';
    foreach(keys(%$day_hash)) {
      if($_ =~ /^E/ && $day_hash->{$_} == 1) {
        $day_list .= $_.',';
      }
    }
    # Remove trailing comma 
    chop($day_list);
    my %schedule_data = (	TEAM_ID => $team_id,
				DAY => uc($day),
                        	EMP_LIST => $day_list
		        );
    my $result = $default_schedule->create(\%schedule_data);
    if(!$result) {
      $result = $default_schedule->delete({TEAM_ID => $team_id});
      croak "Failed DB insert";
    }
  }
}

sub get_db {
  return shift->{db};
}

1;
