set :deploy_to, "/var/www/apps/#{application}"
set :domain, "danielsteiner.de"

set :user, 'steini'

#set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
set(:mongrel_conf) { "#{current_path}/config/mongrel_cluster.yml" }

set :runner, nil

role :web, domain
role :app, domain
role :db, domain, :primary => true

task :link_shared_stuff do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  #run "ln -nfs #{shared_path}/config/cookie_secret #{release_path}/config/cookie_secret"
end

after "deploy:symlink", "link_shared_stuff"