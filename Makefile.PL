#!/usr/bin/env perl

use 5.008007;

use strict;
use warnings;

use ExtUtils::MakeMaker;

my ($mm) = $ExtUtils::MakeMaker::VERSION =~ /^([^_]+)/;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::ISAjax',
  VERSION_FROM => 'lib/Mojolicious/Plugin/ISAjax.pm',
  ABSTRACT     => 'Browses online documentation of your Mojolicious application',
  AUTHOR       => 'Viliam Pucik <viliam.pucik@gmail.com>',

  ($mm < 6.3002 ? () : ('LICENSE' => 'artistic_2')),

  ( $mm < 6.46
    ? ()
    : (
      META_MERGE => {
        requires  => {perl => '5.008007'},
        resources => {
          homepage    => 'https://github.com/viliampucik/Mojolicious-Plugin-ISAjax',
          license     => 'http://dev.perl.org/licenses/',
          repository  => 'git://github.com/viliampucik/Mojolicious-Plugin-ISAjax.git',
        },
        no_index => {directory => [qw/t/]}
      },
      META_ADD => {
        build_requires     => {},
        configure_requires => {}
      },
    )
  ),

  PREREQ_PM    => { 'Mojolicious' => '1.80' },
  test         => { TESTS => 't/*.t' }
);
