task :start do
	dir = File.dirname(__FILE__)
	system("bundle exec unicorn_rails -c #{dir}/unicorn.conf --path /#{ENV['N']} --listen /tmp/unicorn_#{ENV['N']}.sock -D")
end

task :stop do
	pid = File.read("./unicorn.pid").to_i
	Process.kill :QUIT, pid
end

task :restart => [:stop,:start] do
end

task :debug do
	system('bundle exec ruby app.rb -o 0.0.0.0')
end

task default: :debug