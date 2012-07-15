package TeamDB;

use strict;
use warnings;
use base 'BaseDB';

sub new { 
  my ($class, $db) = @_;
  my $self  = $class->SUPER::new($db);
  $self->{table_name} = 'TEAM';
  bless $self, $class;
  return $self; 
}

sub select {
  my($self, $where, $select_fields) = @_;
  if (!$select_fields) {
    $select_fields =  
	[ 'TEAM_ID', 'COMPANY', 'TEAM_NAME', 'TEAM_MAX_SIZE_WKDAY', 'TEAM_MIN_SIZE_WKDAY', 'TEAM_MAX_SIZE_WKEND', 'TEAM_MIN_SIZE_WKEND' ]; 
    
  }
  my $result = $self->SUPER::select($where, $select_fields);
  return $result;
}

sub table_name {
  return shift->{'table_name'};
}

1;
