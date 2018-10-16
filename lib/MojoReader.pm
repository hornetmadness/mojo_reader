package MojoReader;
use Mojo::Base 'Mojolicious';
use MojoReader::Model::Users;
use MojoReader::Model::Addfeed;

my $config;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  $config = $self->plugin('Config');

  auth($self);

  my $r = $self->routes;

  $self->helper(addfeed => sub { state $addfeed = MojoReader::Model::Addfeed->new });

  $r->get('/settings')->to('settings');
  $r->post('/addfeed')->to('managefeeds#add');

}

sub auth {
  my $self = shift;

  $self->secrets($config->{secrets});
  $self->session(expiration => $config->{session_expire} || 3600 );
  
  $self->helper(users => sub { state $users = MojoReader::Model::Users->new });


  my $r = $self->routes;
  $r->any('/')->to('auth#index')->name('index');

  my $logged_in = $r->under('/')->to('auth#logged_in');
  $logged_in->get('/default')->to('loggedin#default');

  $r->get('/logout')->to('auth#logout');
}

1;
