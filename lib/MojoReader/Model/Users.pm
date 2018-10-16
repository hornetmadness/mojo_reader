package MojoReader::Model::Users;

use strict;
use warnings;

use Mojo::Util 'secure_compare';

my $USERS = {
  emathis      => 'l3tm31n!'
};

sub new { bless {}, shift }

sub check {
  my ($self, $user, $pass) = @_;

  #my $config = $self->plugin('Config');
  #$self->session(expiration => $config->{session_expire});

  # Success
  return 1 if $USERS->{$user} && secure_compare $USERS->{$user}, $pass;

  # Fail
  return undef;
}

1;
