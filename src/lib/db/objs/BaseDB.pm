package BaseDB;

use strict;
use warnings;

use Constants;
use Carp;
use Data::Dumper;
use SQL::Abstract;

sub new {
  my ($class, $db) = @_;
  if(!$db) {
    croak "DB obfect not passed" unless($db);
  }
  my $self = {};
  $self->{db} = $db;
  bless $self, $class; 
  return $self;
}

sub test {
  print "Hello \n";
}

sub create {
  my ($self, $details) = @_;
  unless(ref($details) eq 'HASH') {
    croak "A hash reference needs to be passed";
  }
  my $table = $self->table_name();
  unless($table) {
    croak "No table name specified";
  }
  my $db = $self->get_db;
  my $result = $db->insert($table, $details); 
  return $result;
}

sub delete {
  my ($self, $where) = @_;
  my $db = $self->get_db();
  my $tname = $self->table_name();
  my $result = $db->delete($tname, $where);
  return $result;
} 

sub select {
  my($self, $where, $select_fields, $sort_by) = @_;
  my $db = $self->get_db();
  my $tname = $self->table_name();
  my $result = $db->select($tname, $select_fields, $where);
  return $result;
}

sub update {
  my($self, $update_fields, $where ) = @_;
  my $db = $self->get_db();
  my $tname = $self->table_name();
  my $result = $db->update($tname, $update_fields, $where);
  return $result;
}
sub get_db {
  return shift->{db};
}
1;
