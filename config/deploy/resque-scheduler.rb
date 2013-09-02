namespace :deploy do
  namespace :resque do
    namespace :scheduler do
      desc "stop the resque-scheduler server"
      task :stop, :roles => :app do
        run "[ ! -f #{current_path}/tmp/pids/resque-scheduler.pid ] || kill `cat #{current_path}/tmp/pids/resque-scheduler.pid` || true"
      end

      desc "start the resque-scheduler server"
      task :start, :roles => :app do
        run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{current_path}/tmp/pids/resque-scheduler.pid BACKGROUND=yes bundle exec rake resque:scheduler"
      end

      desc "restart the resque-scheduler server"
      task :restart, :roles => :app do
        run "[ ! -f #{current_path}/tmp/pids/resque-scheduler.pid ] || kill `cat #{current_path}/tmp/pids/resque-scheduler.pid` || true"
        run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{current_path}/tmp/pids/resque-scheduler.pid BACKGROUND=yes bundle exec rake resque:scheduler"
      end
    end
  end
end

before 'deploy:resque:stop', 'deploy:resque:scheduler:stop'
after 'deploy:resque:restart', 'deploy:resque:scheduler:restart'
after 'deploy:resque:start', 'deploy:resque:scheduler:start'
