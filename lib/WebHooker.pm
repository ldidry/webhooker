package WebHooker;
use Mojo::Base 'Mojolicious';
use Mojo::JSON qw(decode_json);
use Mojo::URL;
use Config::GitLike;
use Git::Sub qw(push);

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('Config', default => {
            repo_dir => '/home/git/repositories',
        }
    );

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->post('/:user/*repo' => sub {
        my $c   = shift;
        my $msg = decode_json($c->req->content->asset->slurp);

        my $repository = $msg->{repository}->{name};

        if (defined($c->config->{authorized}) && $c->config->{authorized}->{$msg->{project_id}} ne $c->param('user').'/'.$c->param('repo')) {
            $c->app->log->info('Not authorized');
            return $c->render(
                text   => $repository.' not authorized to mirror to github/'.$c->param('user').'/'.$c->param('repo'),
                status => 200
            );
        }

        # Go to the right directory
        my $sub_dir = Mojo::URL->new($msg->{repository}->{url})->path;
        my $repo_dir = $c->config->{repo_dir};
        $repo_dir    =~ s#/$##;
        my $dir      = $repo_dir.'/'.$sub_dir.'/';
        return $c->app->log->info($dir.' does not exists or is not a directory. Mirroring for '.$repository.' aborted.') unless (-d $dir);
        chdir $dir;

        # Check configuration
        my $data   = Config::GitLike->load_file('config');
        my $writer = Config::GitLike->new(confname => 'config');
        my $github_url = 'https://'.$c->config->{github}->{user}.':'.$c->config->{github}->{passwd}.'@github.com/';
        my $old_config = (defined($data->{'remote.github.url'}) && $data->{'remote.github.url'} !~ m/https/);
        unless (defined($data->{'remote.github.url'}) && defined($data->{'remote.github.mirror'}) && !($old_config)) {
            if (defined($c->param('user')) && defined($c->param('repo'))) {
                $c->app->log->info('git config does not contain github informations or need updating, doing configuration');
                $writer->set(
                    key      => 'remote.github.url',
                    value    => $github_url.$c->param('user').'/'.$c->param('repo'),
                    filename => 'config'
                ) unless (defined($data->{'remote.github.url'}) && !($old_config));
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

        $c->app->log->info($repository.' mirrored to github because of '.$msg->{user_name}.' (or at least tryed to be mirrored)');
        $c->render(
            text   => $repository.' mirrored to github (or at least tryed to be mirrored)',
            status => 200
        );
    });
}

1;
