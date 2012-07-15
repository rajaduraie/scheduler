package OverrideScheduleDB;

use strict;
use warnings;
use base 'BaseDB';

sub new { 
  my ($class, $db) = @_;
  my $self  = $class->SUPER::new($db);
  $self->{table_name} = 'OVERRIDE_SCHEDULE';
  bless $self, $class;
  return $self; 
}

sub select {
  my($self, $where, $select_fields) = @_;
  if (!$select_fields) {
    $select_fields =  
	[ 'TEAM_ID', 'CAL_DATE', 'SHIFT', 'OLD_EMP', 'NEW_EMP' ]; 
    
  }
  my $result = $self->SUPER::select($where, $select_fields);
  return $result;
}

sub table_name {
  return shift->{'table_name'};
}

1;
