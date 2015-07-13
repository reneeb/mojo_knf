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

  my $params = $self->req->params->to_hash;

  # validiere Formulareingaben
  my $validation = $self->validation;

  $validation->required('name')->is_name();
  $validation->optional('email')->is_email();

  if ( $validation->has_error ) {
      my $time = localtime;

      my %errors;
      for my $field ( @{ $validation->failed } ) {
          $errors{$field . '_ERROR'} = 'style="color: red;"';
      }

      $self->render( 'guest/contact', %{$params}, %errors, year => $time->year );
      return;
  }

  $self->render( text => 'Die Mail wurde versendet' );
}

sub imprint {
  my $self = shift;

  $self->render();
}

1;
