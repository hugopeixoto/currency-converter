require 'rubygems'
require 'sinatra'
require 'yaml'

require 'haml'
require 'active_record'

# Misc gem configuration
dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])

load 'partials.rb'
load 'models/currency.rb'

helpers Sinatra::Partials

# Sinatra configuration
set :haml, format: :html5
set :views, File.dirname(__FILE__) + "/views"
set :public_dir, File.dirname(__FILE__) + '/public'
enable :static

# Requests
get '/' do
  content_type 'text/html', charset: 'utf-8'
  haml :index
end
