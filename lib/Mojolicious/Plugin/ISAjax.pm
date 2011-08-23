package Mojolicious::Plugin::ISAjax;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '1.00';

sub register {
  my ($self, $app, $args) = @_;

  my $stash = $args->{stash} || 'isajax';

  $app->hook(
    before_dispatch => sub {
      my $self = shift;

      my $ajaxheader = $self->req->headers->header('X-Requested-With');
      $self->stash->{$stash} = 1 if ($ajaxheader && $ajaxheader eq 'XMLHttpRequest');
      
    }
  );

  # Add "isajax" helper
  $app->helper(isajax => sub { shift->stash->{$stash} });
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::ISAjax - XMLHttpRequest Detection Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('ISAjax');

  # Mojolicious::Lite
  plugin 'ISAjax';

  # Example of usage in a template
  % if ( isajax ) {
  % layout 'ajax';
  % } else {
  % layout 'default';
  % }

  # Example of usage in a controller
  return $self->render(template => 'foo/ajax') if $self->isajax;

=head1 DESCRIPTION

Distinguish between normal requests and Ajax requests by checking
C<XMLHttpRequest> string in C<X-Request-With> header and set stash value for
C<isajax> accordingly.

Also exports C<isajax> helper.

L<Mojolicious::Plugin::ISAjax> is a L<Mojolicious> plugin.

=head1 OPTIONS

=head2 C<stash>

  # Mojolicious
  $self->plugin('ISAjax' => {stash => 'ajax'});

  # Mojolicious::Lite
  plugin 'ISAjax' => {stash => 'ajax'};

Stash name for Ajax flag, defaults to C<isajax>.

=head1 HELPERS

=head2 C<isajax>

  % if ( isajax ) {
  <h1>Hello from Ajax Request</h1>
  % }

  $self->isajax;

Returns C<1> in case of an Ajax request. Otherwise returns C<undef>.

=head1 METHODS

L<Mojolicious::Plugin::ISAjax> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register;

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
