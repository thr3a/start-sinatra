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
rake
#→ http://localhost/:4567
```
## Unicorn+Nginxを使って運用する場合
予めNginxはインストールされているものとする

**start-sinatra**の部分は運用ディレクトリ名と同一でなければならないので注意
###nginx.conf
**http{}**の中に以下を追記
```
upstream unicorn_server_hogehoge {
	server unix:/tmp/unicorn_start-sinatra.sock;
}
```
###sites-available/unicorn
```
server {
	server_name _;
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
ただしSocket.IOのようなWebSocketを使う場合は以下も追記
```
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
```


**/etc/nginx/sites-available/unicorn**を**/etc/nginx/sites-enabled/**へシンボリックリンクを貼る
```
 sudo ln -s /etc/nginx/sites-available/unicorn /etc/nginx/sites-enabled/
```
```
rake start #起動
rake stop #停止
rake restart #再起動
```
## Licence

[MIT](http://opensource.org/licenses/mit-license.php)