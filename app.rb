# encoding: utf-8

require 'bundler'
Bundler.require

get '/' do
  erb :index
end

