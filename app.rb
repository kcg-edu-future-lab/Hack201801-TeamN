# encoding: utf-8

require 'bundler'
Bundler.require

require "json"

configure do
  enable :sessions
end

before do
  if session[:employeeId] != nil then
    client = Mongo::Client.new('mongodb://localhost/yabee')
    collection = client[:users]
    user = collection.find({'employeeId' => session[:employeeId]}).first
    @employeeId = session[:employeeId]
    @name = session[:name]
    @isFree = user[:isFree]
  end
end

get "/" do
  if session[:employeeId] != nil then
      redirect "/home"
  else
      erb :login
  end
end

post "/login" do
  client = Mongo::Client.new('mongodb://localhost/yabee')
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
      erb :index
  end
end

get "/api/free" do
  client = Mongo::Client.new('mongodb://localhost/yabee')
  collection = client[:users]
  freeUsers = collection.find({'isFree' => "true"}).inject([]){|us,u|
     us << u[:employeeId]
  }
  return JSON.generate(freeUsers)
end

post "/api/free/set" do #isFreeを送って
  client = Mongo::Client.new('mongodb://localhost/yabee')
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
  @title = '猫の手リスト'
  DB = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'yabee')
  @employee = DB[:users].find({ isFree: "true" }) || []
  erb :cathandList
end

get '/fixtures' do
  @title = '備品'
  DB = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'yabee')
  @fixtures = DB[:fixtures].distinct('type')
  erb :fixtures
end
