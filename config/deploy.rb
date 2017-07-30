# config valid only for current version of Capistrano
lock "3.9.0"
set :application, "request-off"
set :repo_url, "git@bitbucket.org:requestoffpj/request-off.git"

set :deploy_to, '/home/deploy/request-off'

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
load 'lib/capistrano/tasks/seed.rb'