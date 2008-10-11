require 'capistrano/ext/multistage'

set :default_stage, "production"

set :application, "cash"
set :rails_env, "production"
set :ssh_options, {:forward_agent => true}
set :use_sudo, false

default_run_options[:pty] = true

set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
set :runner, nil

set :scm, "git"
set :branch, "master"
set :repository, "git://github.com/steini/cash.git"
set :keep_releases, 5
set :deploy_via, :remote_cache

namespace :deploy do
  task :restart do
    restart_mongrel_cluster
  end
end