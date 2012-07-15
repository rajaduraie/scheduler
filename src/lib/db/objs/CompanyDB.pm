package CompanyDB;

use strict;
use warnings;
use base 'BaseDB';

sub new { 
  my ($class, $db) = @_;
  my $self  = $class->SUPER::new($db);
  $self->{table_name} = 'COMPANY';
  bless $self, $class;
  return $self; 
}

sub select {
  my($self, $where, $select_fields) = @_;
  if (!$select_fields) {
    $select_fields =  
	[ 'ID', 'NAME', 'ADDRESS_STR1', 'ADDRESS_STR2', 'ADDRESS_CITY', 'ADDRESS_ZIP', 'ADDRESS_STATE', 'ADDRESS_COUNTRY' ]; 
    
  }
  my $result = $self->SUPER::select($where, $select_fields);
  return $result;
}

sub table_name {
  return shift->{'table_name'};
}

1;
