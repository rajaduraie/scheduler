package DayDB;

use strict;
use warnings;
use base 'BaseDB';

sub new { 
  my ($class, $db) = @_;
  my $self  = $class->SUPER::new($db);
  $self->{table_name} = 'DAY';
  bless $self, $class;
  return $self; 
}

sub select {
  my($self, $where, $select_fields) = @_;
  if (!$select_fields) {
    $select_fields =  
	[ 'DAY' ]; 
    
  }
  my $result = $self->SUPER::select($where, $select_fields);
  return $result;
}

sub table_name {
  return shift->{'table_name'};
}

1;
