check_client_connection false
listen "/home/gambala/git/pizza/tmp/sockets/pizza.socket", backlog: 1024
listen "127.0.0.1:8080", tcp_nopush: true
pid "/home/gambala/git/pizza/tmp/pids/unicorn.pid"
preload_app true
stderr_path "/home/gambala/git/pizza/log/unicorn.stderr.log"
stdout_path "/home/gambala/git/pizza/log/unicorn.stdout.log"
timeout 15
worker_processes 1
working_directory "/home/gambala/git/pizza"

GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  Resque.redis.quit if defined?(Resque)
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
  Resque.redis = 'localhost:6379' if defined?(Resque)
end
