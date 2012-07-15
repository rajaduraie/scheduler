package ReplacingEmp;

use strict; 
use base 'BaseScheduler';

use Db;
use 

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
  my($self) = @_;
  # TODO - Get a list of people not working on that day
  # TODO - Remove names of ppl already taking leave that day
  # TODO - Pick names of ppl with max leaves taken 
  # TODO - If no names, pick people same shift with atleast one prev day out of office 
  # TODO - If no names, pick people with same shift with 16 hour gap
}
