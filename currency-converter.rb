require 'rubygems'
require 'sinatra'

require 'haml'
require 'active_record'

load 'partials.rb'
load 'models/currency.rb'

helpers Sinatra::Partials

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])

set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + '/public'
set :run, true
enable :static

get '/' do
  haml :index
end


