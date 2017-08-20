use strict;
use warnings;

use DBIx::Class::Schema::Loader qw/make_schema_at/;

make_schema_at (
  'Robots::Schema', 
  {debug => 0, dump_directory => '.',
  generate_pod => 0,  },
  ['dbi:mysql:robodb:localhost:3306', 'root', 'password!']
);
 
