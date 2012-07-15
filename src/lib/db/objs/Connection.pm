
package Connection;

use strict;
use base 'DBIx::Simple';

use Constants;

sub new {
  my $class = shift;
  my $dsn = $DB{DSN};
  my $self    = $class->SUPER::connect($dsn, $DB{DBUSER}, $DB{DBPASS});
  return undef unless($self);
  bless $self, $class;
  return $self;
}

1;
