require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/sidekiq'
require 'capistrano/unicorn_nginx'
require 'capistrano/sitemap_generator'
require 'capistrano/figaro_yml'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
