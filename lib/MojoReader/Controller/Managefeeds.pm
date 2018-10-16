package MojoReader::Controller::Managefeeds;
use Mojo::Base 'Mojolicious::Controller';


sub add {
  my $self = shift;
  my $url=$self->param('url');

  dumper $self unless $self->addfeed->check($url); 
}

1;
