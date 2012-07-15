package UpdateSchedule;

use strict;

use base 'BaseScheduler';
use DefaultScheduleDB;
use OverrideSchduleDB;
use Utils;

use Carp;

sub new {
  my ($class) = @_;
  my $self = $class->SUPER::new();
  bless $self, $class;
  return $self;
}
sub manual_update {
  my ($self, $params) = @_;
  my $old_emp = $params->{old_emp};
  my $new_emp = $params->{new_emp};
  return $self->update($params, $old_emp, $new_emp);
}
  
sub auto_update {
  my($self, $params, $old_emp) = @_;
  my @new_emps = $self->get_eligible_emps($params);
  my $new_emp = '';
  foreach(@new_emps) {
    $new_emp = $self->check_availability($_);
    if($new_emp) {
      return $self->update($params, $new_emp,$old_emp);
    }
  }
  return undef;
}

sub create_override_row {
  my($self, $params) = @_;
  my $data = ( TEAM_ID => $params->{team_id},
               SHIFT => $params->{shft} || '2',
               CAL_DAY => $params->{ },
               OLD_EMP => $params->{old_emp},
               NEW_EMP => $params->{new_emp}
             );
}

sub update {
  my($self, $params, $new_emp, $old_emp) = @_;
  my $shft = $params->{shft};
  my $team_id = $params->{team_id};
  my $day = uc($params->{day});
  unless($shft && $team_id && $day && ($new_emp || $old_emp)) {
    croak "Required parameters missing";
  }
  my $db = $self->get_db();
  my $default_schedule = DefaultScheduleDB->new($db);
  my %where = ( TEAM_ID => $team_id,
                DAY => $day,
                SHIFT => $shft,
              );
  my @fields = qw(EMP_LIST);
  my $result = $default_schedule->select(\%where, \@fields);
  my $default = '';
  while(my $row = $result->fetch) {
    $default = $row->[0];
  }
  if (!$default) {
    warn "There is no default schedule for this shift \n";
    return undef;
  }
  my $emps = Utils::hashref_from_string($default);
  unless ($emps->{$old_emp}) {
    warn "This employee is not in the default list";
    return undef;
  } else {
    delete $emps->{$old_emp};
  }
  if (!$new_emp) {
    warn " There will less than required employees for this shift";
  } else {
    $emps->{$new_emp}++;
  }
  return $emps;
}

1;
