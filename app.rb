# encoding: utf-8

require 'bundler'
Bundler.require

require "json"

configure do
  enable :sessions
end

get "/" do
  if session[:employeeId] != nil then
      redirect "/home"
  else
      erb :login
  end
end

post "/login" do
  client = Mongo::Client.new('mongodb://localhost/hat')
  collection = client[:users]
  user = collection.find({'employeeId' => params[:employeeId]}).first

  session[:employeeId] = params[:employeeId]
  session[:name] = user[:name]
  redirect "/home"
end

get "/home" do
  if session[:employeeId] == nil then
      redirect "/"
  else
      @employeeId = session[:employeeId]
      @name = session[:name]
      erb :index
  end
end

get "/api/free" do
  client = Mongo::Client.new('mongodb://localhost/hat')
  collection = client[:users]
  freeUsers = collection.find({'isFree' => true}).inject([]){|us,u|
     us << u[:employeeId]
  }
  return JSON.generate(freeUsers)
end

post "/api/free/set" do #isFreeを送って
  client = Mongo::Client.new('mongodb://localhost/hat')
  collection = client[:users]
  isFree = params[:isFree]
  collection.update_one({'employeeId' => session[:employeeId]}, {'$set' => {'isFree' => isFree}})
  return "ok"
end

get "/logout" do
  session.clear
  redirect '/'
end

get "/cathandList" do
  @employee = db.users.find({isFree:true});
  erb :cathandList
end

