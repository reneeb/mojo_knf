package Streetart::Controller::Gallery;
use Mojo::Base 'Mojolicious::Controller';

use File::Basename;

# This action will render a template
sub show {
  my $self = shift;

  my $path  = $self->app->home . '/public/images/' . $self->param('city');
  my @files = map{ basename $_ }grep{ -f $_ }glob( "$path/*" );

  $self->render( images => \@files );
}

1;
