package Streetart::Controller::Gallery;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub show {
  my $self = shift;

  $self->render();
}

1;
