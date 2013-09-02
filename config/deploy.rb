#encoding:utf-8
require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano-unicorn'

set :application, "bitwin"
set :repository, "https://github.com/songjiayang/bitwin.git"
set :branch, "master"

set :scm, :git

set :user, "ubuntu"
set :use_sudo, false

# 部署路径修改为当前用户的目录，如果用默认的根目录且没有root权限会引起Permission denied的错误
set :deploy_to, "/home/#{user}/app/#{application}"
set :deploy_via, :remote_cache # 不要每次都获取全新的repository
set :deploy_server, '54.213.197.200'

role :web, "#{deploy_server}"                          # Your HTTP server, Apache/etc
role :app, "#{deploy_server}"                          # This may be the same as your `Web` server
role :db,  "#{deploy_server}", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  desc "Start Application"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop Application"
  task :stop, :roles => :app do
    run "kill -QUIT `cat #{shared_path}/pids/unicorn.#{application}.pid`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end

  desc "Populates the Production Database"
  task :seed do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:seed"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"), "#{shared_path}/config/database.yml"
  end

  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml  #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update","deploy:symlink_config"
end

after 'deploy:restart', 'unicorn:reload'   # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded

load 'config/deploy/resque'
load 'config/deploy/resque-scheduler'