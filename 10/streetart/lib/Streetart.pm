package Streetart;
use Mojo::Base 'Mojolicious';

use Time::Piece;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Prüfungen hinzufügen. Achtung! Sub muss "0" zurückgeben wenn der Wert
  # valide ist und "1" bei einer fehlerhaften Eingabe
  my $validator = $self->validator;
  $validator->add_check(
    is_name => sub {
        $_[2] !~ m{\A [A-Za-z.\ ]{3,} \z};
    }
  );

  $validator->add_check(
    is_email => sub {
        $_[2] !~ m{\@};
    }
  );

  # Hilfsfunktionen
  $self->helper(
    date => sub {
      my $time = localtime;
      return $time->dmy('.');
    }
  );

  $self->helper(
    year => sub {
      my $time = localtime;
      return $time->year;
    }
  );

  $self->helper(
    ip => sub {
      my $c = shift;
      return $c->tx->remote_address;
    }
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller

  #/                          | GET     | Startseite - Carousel mit drei Bildern
  $r->get('/')->to('guest#welcome');
#      ^   ^         ^      ^
#      |   |         |      |
#   Für    |         |      |
#   GET-   |         |      |
#   Req   URL: /     |      |
#                Controller |
#                           Subroutine


  #/show/frankfurt            | GET     | Galerie mit Bildern aus Frankfurt
  #/show/hannover             | GET     | Galerie mit Bildern aus Hannover
  #/show/berlin               | GET     | Galerie mit Bildern aus Berlin
  $r->get(
      '/show/:city',
      { city => 'frankfurt' },  # Defaultwert für city. Der Platzhalter wird dadurch optional
      [ city => qr/[a-z]+/ ],   # Stadtname darf nur a-z sein
  )->to('gallery#show');

  # json-Auflistung
  $r->get(
      '/show/:city/json',
      { city => 'frankfurt' },  # Defaultwert für city. Der Platzhalter wird dadurch optional
      [ city => qr/[a-z]+/ ],   # Stadtname darf nur a-z sein
  )->to('gallery#show_json');

  #/contact                   | GET     | Anzeige Kontaktformular
  $r->get('/contact')->to('guest#contact');

  #/contact                   | POST    | Kontaktformular absenden
  $r->post('/contact')->to('guest#contact_send');

  #/imprint                   | GET     | Impressum anzeigen
  $r->get('/imprint')->to('guest#imprint');

  #/user/upload               | GET     | Formular um Bilder hochzuladen
  $r->get('/user/upload')->to('user#upload');
  #/user/upload               | POST    | Bild hochladen
  $r->post('/user/upload')->to('user#upload_do');

  #/user/comment              | GET     | Formular für Kommentar
  $r->get('/user/comment')->to('user#comment');
  #/user/comment              | POST    | Kommentar absenden
  $r->post('/user/comment')->to('user#comment_save');
}

1;
