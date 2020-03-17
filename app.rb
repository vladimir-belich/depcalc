require 'sinatra/base'
require 'byebug'

class App < Sinatra::Base
  get '/' do
    erb :calc
  end
 end
