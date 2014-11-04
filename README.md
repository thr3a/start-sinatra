Start-Sinatra
====

##Overview
Sinatra + Unicorn向けに作られた骨組み
## Install

```sh
git clone https://github.com/thr3a/start-sinatra.git
cd start-sinatra/
bundle install
```
##Sinatra単体で実行する場合
```
bundle exec ruby app.rb -o 0.0.0.0
```
## Unicorn+Nginxを使って運用する場合
予めNginxとUnicornはインストールされているものとする

###nginx.conf
**http{}**の中に以下を追記
```
upstream unicorn_server_hogehoge {
	server unix:/tmp/unicorn_hogehoge.sock;
}
```
###sites-available/unicorn
```
server {
	server_name example.com;
	listen 80;
	location /start-sinatra/ {
		proxy_pass http://unicorn_server_hogehoge;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Host $http_host;
		proxy_set_header Host $host;
	}
}
```
**/etc/nginx/sites-available/unicorn**を**/etc/nginx/sites-enabled/**へシンボリックリンクを貼る
```
 sudo ln -s /etc/nginx/sites-available/unicorn /etc/nginx/sites-enabled/
```
実行
```
unicorn_rails -c unicorn.conf --path /start-sinatra -D
```
停止
```
kill `cat unicorn.pid`
```
## Licence

[MIT](http://opensource.org/licenses/mit-license.php)