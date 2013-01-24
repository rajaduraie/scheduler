package Company;

use strict;
use warnings;

use base 'CompanyDB';

use Carp;

sub new {
  my($class, $db) = @_;
  if(!$db) {
    croak "The DB connection needs to be passed";
  }
  $self = $class->SUPER::new($db);
  bless $self, $class;
  return $self;
}

sub create {
  my ($this, $data) = @_;
  my ($result) = $this->create($data);
  return $result;
}

sub update {
  my($this, $data);
  my $cols = '';
  my $vals = '';
  foreach (keys %$data) {
    
