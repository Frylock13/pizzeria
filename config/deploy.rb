set :application, 'pizza'
set :deploy_to, "/home/deployer/apps/#{fetch(:application)}"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/assets public/sitemaps}
set :linked_files, %w{config/application.yml}
set :log_level, :info
set :repo_url, 'git@bitbucket.org:gambala/pizza.git'
set :sidekiq_queue, ['default', 'mailers']
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
