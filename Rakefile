task :start do
	#カレントディレクトリのディレクトリ名を取得
	dir = `pwd`.split("/").last.delete("\n")
	system("bundle exec unicorn_rails -c unicorn.conf --path /#{dir} --listen /tmp/unicorn_#{dir}.sock -D")
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