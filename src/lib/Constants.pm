package Constants;

#use strict;
use warnings;

use base 'Exporter';

use Readonly;

Readonly our %DB => ( DSN    => 'dbi:mysql:schedule:localhost:3306',
                      DBUSER => 'root',
                      DBPASS => 'Havefun!'
                    );
Readonly::Scalar our $LOGGER_FILE => '/etc/log.conf';
@EXPORT = qw(%DB $LOGGER_FILE);
#Readonly::Scalar our $DB     => 'schedule';
#Readonly::Scalar our $DSN    => 'dbi:mysql:'.$DB.':localhost:3306';
#Readonly::Scalar our $DBUSER => 'root';
#Readonly::Scalar our $DBPASS => 'Havefun!';
