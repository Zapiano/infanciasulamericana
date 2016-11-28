require 'sinatra'
require 'sinatra/bootstrap'
require 'sass/plugin/rack'
require 'pry'
require 'dotenv'
require 'pony'

Dotenv.load

register Sinatra::Bootstrap::Assets

get '/' do
  @page = 'index'

  erb :index
end

get '/contato' do
  @page = 'contact'

  erb :contact
end

get '/cidade' do
  @page = 'city'

  erb :city
end

get '/programacao' do
  @page = 'schedule'

  erb :schedule
end

get '/equipe' do
  @page = 'team'

  erb :team
end

get '/cidade' do
  @page = 'city'

  erb :city
end

get '/inscricoes' do
  @page = 'registrations'

  erb :registrations
end
