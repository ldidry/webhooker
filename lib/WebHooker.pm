package WebHooker;
use Mojo::Base 'Mojolicious';
use Mojo::JSON qw(decode_json);
use Mojo::URL;
use Config::GitLike;
use Git::Sub qw(push);

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('Config');

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->post('/:ssh_nickname/:user/:repo' => sub {
        my $c   = shift;
        my $msg = decode_json($c->req->content->asset->slurp);

        my $repository = $msg->{repository}->{name};

        # Go to the right directory
        my $sub_dir = Mojo::URL->new($msg->{repository}->{url})->path;
        my $dir     = '/home/git/repositories/'.$sub_dir.'/';
        return $c->app->log($dir.' does not exists or is not a directory. Mirroring for '.$repository.' aborted.') unless (-d $dir);
        chdir $dir;

        # Check configuration
        my $data   = Config::GitLike->load_file('config');
        my $writer = Config::GitLike->new(confname => 'config');
        unless (defined($data->{'remote.github.url'}) && defined($data->{'remote.github.mirror'})) {
            if (defined($c->param('ssh_nickname')) && defined($c->param('user')) && defined($c->param('repo'))) {
                $c->app->log->info('git config does not contain github informations, doing configuration');
                $writer->set(
                    key      => 'remote.github.url',
                    value    => $c->param('ssh_nickname').':'.$c->param('user').'/'.$c->param('repo'),
                    filename => 'config'
                ) unless (defined($data->{'remote.github.url'}));
                $writer->set(
                    key      => 'remote.github.mirror',
                    value    => 'true',
                    filename => 'config'
                ) unless (defined($data->{'remote.github.mirror'}));
            } else {
                $c->app->log->info('Error in repository '.$sub_dir.': git config does not contain (enough?) github informations and neither does WebHooker');
                return $c->app->log->info('Aborting push for repository '.$sub_dir);
            }
        }

        $c->app->log->info(git::push qw(--quiet github));

        $c->app->log->info($repository.' mirrored to github (or at least tryed to be mirrored)');
        $c->render(
            text   => $repository.' mirrored to github (or at least tryed to be mirrored)',
            status => 200
        );
    });
}

1;
