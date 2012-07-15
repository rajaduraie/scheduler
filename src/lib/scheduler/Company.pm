package Company;

use strict;
use base 'CompanyDB';

sub new {
  my($class, $db, $id) = @_;
  my $self = {};
  unless($db) {
    croak "DB Object has to be passed";
  }
  my $db_obj = CompanyDB->new($db);
  my $comp_details = $db_obj->select({COMPANY_ID => $id});
  if($comp_details->dummy()) {
    return undef;
  }
  
}

foreach(''company_id', '
1;
