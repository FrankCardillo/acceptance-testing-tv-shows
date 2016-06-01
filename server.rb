require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get "/" do
  redirect "/television_shows"
end

get "/television_shows" do
  erb :index
end

get "/television_shows/new" do

end
