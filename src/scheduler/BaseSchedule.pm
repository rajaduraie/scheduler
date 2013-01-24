package BaseSchedule;

use strict;
use warnings;

use Data::Dumper;
use Carp;
use Log::Log4perl; 

use Connection;
use Constants;

sub new {
  my ($class) = @_;
  my $self = {};
  bless $self, $class;

  #Initialize the logger. 
  Log::Log4perl->init($LOGGER_FILE); 
  my $logger = Log::Log4perl->get_logger();
  $self->{logger} = $logger;
  
  #Get the db object
  my $db = Connection->new();
  if(!$db) {
    $logger->fatal("Unable to initialize DB object");
    croak "Cannot connect to database";
  }
  $self->{db} = $db;

  return $self;
}

sub get_db {
  return shift->{db};
}

sub get_logger {
  return shift->{logger};
}

1;
