require 'sinatra'
require 'csv'
require_relative "app/models/television_show"
require_relative "input_helper"
require "pry"
include InputHelper

set :views, File.join(File.dirname(__FILE__), "app/views")

get "/" do
  redirect "/television_shows"
end

get "/television_shows" do
  @television_shows = TelevisionShow.all('television-shows.csv')
  erb :index
end

get "/television_shows/new" do
  @genres = TelevisionShow::GENRES
  erb :new
end

post "/television_shows/post_new" do
  @television_show = TelevisionShow.new(params[:Title], params[:Network], params["Starting Year"], params[:Genre], params[:Synopsis])
  @genres = TelevisionShow::GENRES
  if @television_show.save('television-shows.csv')
    redirect "/television_shows"
  else
    @error = @television_show.errors
    erb :new
  end
end
