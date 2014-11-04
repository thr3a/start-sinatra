require 'bundler'
Bundler.require

#development or production
set :environment, :development
#set :environment, :production

configure :development do
	require 'sinatra/reloader'
	Slim::Engine.set_default_options :pretty => true
end

get '/' do
	@message = "Hello!"
	slim :index
end
