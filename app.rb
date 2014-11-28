require 'bundler'
Bundler.require

#development or production
set :environment, :development
#set :environment, :production

configure :development do
	require 'sinatra/reloader'
	Slim::Engine.set_default_options :pretty => true
end

configure do
	register Sinatra::AssetPack
	assets do
		serve '/js', from: 'assets/js'
		serve '/css', from: 'assets/css'

		js :common, [
			'/js/*.js'
		]

		css :common, [
			'/css/*.css'
		]

		js_compression :closure, :level => "SIMPLE_OPTIMIZATIONS"
		css_compression :sass
	end
end

get '/' do
	@message = "Hello!"
	slim :index
end
