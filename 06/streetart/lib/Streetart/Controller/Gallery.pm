package Streetart::Controller::Gallery;
use Mojo::Base 'Mojolicious::Controller';

use File::Basename;
use Time::Piece;

# This action will render a template
sub show {
  my $self = shift;

  my $path  = $self->app->home . '/public/images/' . $self->param('city');
  my @files = map{ basename $_ }grep{ -f $_ }glob( "$path/*" );
  my $time  = localtime;

  $self->render( images => \@files, year => $time->year );
}

1;
