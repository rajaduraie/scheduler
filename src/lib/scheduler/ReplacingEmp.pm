package ReplacingEmp;

use strict; 
use base 'BaseScheduler';

use Db;
use EmployeeDB;
use DefaultScheduleDB;
use OverrideScheduleDB;


# Create new object
sub new {
  my($class, $company_id, $shft) = @_;
  my $self = $class->SUPER::new();
  $self->{$company_id} = $company_id;
  $self->{$shft} = $shft;
  bless $self, $class;
  return $self;
} 

# Get initial list of eligible emps 
sub get_initial_list {
  my($self, $day, $shift) = @_;
  my $company = $self->get_company();
  my $team_id = $self->get_team_id();

  # Get the list of employees for the total team for that shift
  my $result = EmployeeDB->select([TEAM_ID=>$team_id SHIFT=>$shift], [LABEL]);
  if($result->dummy()) {
    #check if this is correct call
  }
  my @all_members = ();
  while($arr = $result->fetch()) {
    push @all_members, $arr->[0];
  }
  unless(scalar(@all_members)) {
    throw_fatal('No members for this team');
  }
  
  my $result = DefaultScheduleDB->select([TEAM_ID=>$team_id DAY=>$day SHIFT=>$shift], [EMP_LIST]);
  if($result->dummy()) { 
    ## Check if the correct error is captured in the dummy call, not sure if it is dummy or something else 
  }
  my @emp_list_ = ();
  while($arr = $result->fetch) {
    @emp_list = split(/$arr->[0],','/);
  }
  $result = OverrideScheduleDB->select([TEAM_ID=>$team_id CAL_DATE=>$date SHIFT=>$shift], [NEW_EMP]);
  if($result->dummy()) {
    ## check if the correct error call is dummy. change method name 
  }
  my @overriding_emps = ();
  while($result->fetch) {
    push $arr->[0], @overriding_emp;
  } 

  # TODO - Get a list of people not working on that day
  #Remove emp_list and overriding_emps from all_emps#
  
  # trimmed list of all emps here 

  # TODO - Pick names of ppl with max leaves taken 
  my $emp_string = join(@overriding_emps, ',');
  $emp_string .= ','.join(@emp_list, ',');
  my $sql = "Select OLD_EMP from OVERRIDE_SCHEDULE where 
             CAL_DATE < sysdate and 
             TEAM_ID = '$team_id' and 
             SHIFT = '$shift' and 
             NOT IN($emp_string) GROUP BY OLD_EMP SORT DESC";
  

  $result = $Db->query($sql);
  my @sorted_emps
  while($result->fetch()) {
    if($arr->[0] ) { 
      ### The if condition needs to be changed to checked if the element is in the array
      push @sorted_emps, $arr->[0];
    }
  }

  return \@sorted_emps;
  # Remove people already present, and already            
  # TODO in VERSION 2- If no names, pick people same shift with atleast one prev day out of office 
  # TODO in VERSION 2- If no names, pick people with same shift with 16 hour gap
}
