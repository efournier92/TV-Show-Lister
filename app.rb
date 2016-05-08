require "sinatra"
require "csv"
require_relative "models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")
enable :sessions

get "/" do
  redirect "/television_shows"
end

get "/television_shows" do
  @shows = TelevisionShow.all

  erb :index
end

get '/television_shows/new' do
  if session[:failure1]
    @title1 = session[:failure1]
    @title2 = session[:failure2]
    @prior_title = session[:old_title]
    @prior_network = session[:old_network]
    @prior_starting_year = session[:old_starting_year]
    @prior_synopsis = session[:old_synopsis]
    @prior_genre = session[:old_genre]
    session.clear
  else
    @title1 = "Add a New Show"
  end

  @genres = TelevisionShow.list_genres
  erb :new
end

post '/television_shows/new' do
  new_show = TelevisionShow.new(params["title"],
    params["network"],
    params["starting_year"],
    params["synopsis"],
    params["genre"])

  if new_show.valid?
    new_show.save
    redirect "/television_shows"
  else
    session[:old_title] = params[:title]
    session[:old_network] = params[:network]
    session[:old_starting_year] = params[:starting_year]
    session[:old_synopsis] = params[:synopsis]
    session[:old_genre] = params[:genre]
    session[:failure1] = new_show.errors[0]
    session[:failure2] = new_show.errors[1]
    redirect "/television_shows/new"
  end
end
