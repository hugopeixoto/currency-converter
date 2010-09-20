require 'rubygems'
require 'sinatra'

require 'haml'
require 'active_record'

# Misc gem configuration
dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])
set :haml, { :format => :html5 }

load 'partials.rb'
load 'models/currency.rb'

helpers Sinatra::Partials

# Sinatra configuration
set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + '/public'
set :run, true
enable :static

# Requests
get '/' do
  content_type 'text/html', :charset => 'utf-8'
  haml :index
end

