require 'sinatra'
require 'haml'
require 'sass'
require 'coffee-script'

set :haml, :format => :html5
set :scss, :style  => :compressed

get '/' do
	haml :index, :locals => {:title => ''}
end

get '/screenshots' do
	haml :screenshots, :locals => {:title => ' | Screenshots'}
end

get '/css/styles.css' do
	scss :'sass/styles'
end

get '/js/scripts.js' do
	coffee :'coffee/scripts'
end