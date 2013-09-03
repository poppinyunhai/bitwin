namespace :deploy do
  namespace :resque do
    desc "stop the resque server"
    task :stop, :roles => :app do
      run "[ ! -f #{current_path}/tmp/pids/resque.pid ] || kill `cat #{current_path}/tmp/pids/resque.pid` || true"
    end

    desc "start the resque server"
    task :start, :roles => :app do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{current_path}/tmp/pids/resque.pid BACKGROUND=yes QUEUE=* bundle exec rake resque:work"
    end

    desc "restart the resque server"
    task :restart, :roles => :app do
      # Use this format to avoid triggering before and after callbacks needless
      run "[ ! -f #{current_path}/tmp/pids/resque.pid ] || kill `cat #{current_path}/tmp/pids/resque.pid` || true"
      run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{current_path}/tmp/pids/resque.pid BACKGROUND=yes QUEUE=* bundle exec rake resque:work"
    end
  end
end

# NOTE: This is handled by ts:rebuild_manual!!!
# If you changed the ts:rebuild_manual, remember to uncomment this.
#after 'deploy:restart', 'deploy:resque:restart'
after 'deploy:start', 'deploy:resque:start'
after 'deploy:stop', 'deploy:resque:stop'

