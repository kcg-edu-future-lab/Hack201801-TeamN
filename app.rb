# encoding: utf-8

require 'bundler'
Bundler.require

get '/' do
  erb :index
end

get "/cathandList" do
  @employee = db.users.find({isFree:true});
  erb :cathandList
end

