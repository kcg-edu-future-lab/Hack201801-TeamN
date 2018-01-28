# encoding: utf-8

require 'bundler'
Bundler.require

get '/' do
  erb :index
end

get "/cathandList" do
  DB = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'hack')
  @employee = DB[:users].find({ isFree: true }) || []
  erb :cathandList
end

