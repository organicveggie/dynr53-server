require 'sinatra'
require "sinatra/config_file"

class Dynr53Server <  Sinatra::Base
	register Sinatra::ConfigFile
	config_file File.expand_path('../../../config.yml', __FILE__)

	def initialize(app = nil, params = {})
		super(app)
	end

	get '/update/:ip' do
		updater = Route53Updater.new(settings.zone, settings.access_key, settings.secret_key)
		updater.update_host(settings.name, params[:ip])
		"OK"
	end
end
