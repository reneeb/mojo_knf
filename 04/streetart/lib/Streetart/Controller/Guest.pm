package Streetart::Controller::Guest;
use Mojo::Base 'Mojolicious::Controller';

use Time::Piece;

# This action will render a template
sub welcome {
  my $self = shift;

  my $time = localtime;

  $self->render( year => $time->year );
}

sub contact {
  my $self = shift;

  my $time = localtime;

  $self->render( year => $time->year );
}

sub contact_send {
  my $self = shift;

  $self->render();
}

sub imprint {
  my $self = shift;

  $self->render();
}

1;
