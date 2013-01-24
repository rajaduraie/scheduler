package Utils;

use strict;
use Data::Dumper;

sub hashref_from_string { 
  my ($string) = @_;
  my @list = split(/,/, $string);
  my $emps; 
  map {$emps->{$_}++} @list;
  return $emps;
}

1;
