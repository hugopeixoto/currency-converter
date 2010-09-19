require 'rubygems'
require 'sinatra'

require 'haml'
require 'active_record'

load 'partials.rb'
load 'models/currency.rb'

helpers Sinatra::Partials

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'db/production.sqlite3')

set :views, File.dirname(__FILE__) + "/views"
set :public, File.dirname(__FILE__) + '/public'
set :run, true
enable :static

get '/' do
  haml :index
end


