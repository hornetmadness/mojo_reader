package MojoReader::Model::Addfeed;
use Mojo::Base 'Mojolicious';

use strict;
use warnings;

use Mojo::Util;

my $config;

sub new { bless {}, shift }

sub check {
  my $self = shift;

  $config = $self->plugin('Config');

  if ( -e $config->{storage_path} ) {
    return 1;
  }
  # Fail
  return undef;
}

1;
