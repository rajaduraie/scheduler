use Connection;
use CompanyDB;
use TeamDB;
use DefaultScheduleDB;
use DayDB;
use OverrideScheduleDB;
use Test::Simple tests => 10;

# Create a connection
print "Test New connection \n";
my $new = Connection->new();
ok ($new =~ /Connection/, 'Connection successful');

# New company object
print "\nTest Insert, Select, Update and Delete with Company table \n\n";
my $company = CompanyDB->new($new);
$tname = $company->table_name();

my %company_vals = ( 	NAME => 'Test',
			ADDRESS_STR1 => '5 Muthu Nagar',
			ADDRESS_STR2 => 'Kochadai Melakal Main Road',
			ADDRESS_CITY => 'Madurai',
			ADDRESS_STATE => 'TamilNadu',
			ADDRESS_ZIP => '625016',
			ADDRESS_COUNTRY => 'India'
		   );

# Test Insert
my $result = $company->create(\%company_vals);
ok($result->rows == 1,"Created row successfully");

# Test Select
my $where = ( NAME => 'Test',
              ADDRESS_ZIP => '625016'
            );

my $select_fields = '';
#my $select_fields = [qw(NAME ADDRESS_CITY)]; 
$result = $company->select(\%where, $select_fields);
while($arr = $result->fetch) {
  ok ($arr->[1] eq 'Test', 'Select succeeded ');
  ok ($arr->[4] eq 'Madurai', 'Select succeeded ');
}

# Test Update
my %update_fields = (ADDRESS_ZIP => '625001',
                     ADDRESS_STR2 => 'Town Hall Road');
%where = ( NAME => 'Test',
           ADDRESS_CITY => 'MADURAI' );

$result = $company->update(\%update_fields, \%where);
ok($result->rows > 0, 'Successful Update');

# Test Delete
=head
my %del_row = ( NAME => 'Test');
$result = $company->delete(\%del_row);
ok($result->rows > 0,"Deleted row successfully");
=cut
print "\nFor other tables, just check if objects are created as other methods are same \n\n";

my $team = TeamDB->new($new);
$tname = $team->table_name();
ok($tname eq 'TEAM', 'Team table object created');

my $default_schedule = DefaultScheduleDB->new($new);
$tname = $default_schedule->table_name();
ok($tname eq 'DEFAULT_SCHEDULE', 'Defaut schedule table object created');

my $day = DayDB->new($new);
$tname = $day->table_name();
ok($tname eq 'DAY', 'Day table object created');

my $override_schedule = OverrideScheduleDB->new($new);
$tname = $override_schedule->table_name();
ok($tname eq 'OVERRIDE_SCHEDULE', 'Override table created');
