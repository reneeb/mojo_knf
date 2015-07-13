package Streetart::Controller::Guest;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;

  $self->render();
}

sub contact {
  my $self = shift;

  $self->render();
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
