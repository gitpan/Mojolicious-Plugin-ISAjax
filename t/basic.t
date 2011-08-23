#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 9;

use Mojolicious::Lite;
use Test::Mojo;

plugin 'ISAjax';

get '/' => sub {
  my $self = shift;

  if ( $self->isajax ) {
    $self->render_text('Ajax Request');
  }
  else {
    $self->render_text('Normal Request');
  }
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('Normal Request');
$t->get_ok('/' => {'X-Requested-With' => 'XML'})->status_is(200)->content_is('Normal Request');
$t->get_ok('/' => {'X-Requested-With' => 'XMLHttpRequest'})->status_is(200)->content_is('Ajax Request');
