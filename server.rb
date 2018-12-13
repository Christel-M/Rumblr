require "sinatra"
require "sinatra/activerecord"

enable :sessions

if ENV['RACK_ENV'] == 'development'
  set :database, {adapter: "sqlite3", database: "rumblr.sqlite3"}

else
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

class User < ActiveRecord::Base
  has_many :article
end

class Article < ActiveRecord::Base
  belongs_to :user
end

get "/" do

  erb :home
end

####################User##############################
get "/login" do

  erb :"/users/login"
end

post "/users/login" do
  user = User.find_by(email: params["email"])

  if user != nil
    if user.password == params["password"]
      session[:user_id] = user.id
      # redirect "/users/#{user.id}"
      redirect "/dashboard"
    else
      redirect "/login"
    end
  else
    redirect "/users/create-account"
  end
end


post "/logout" do

  session["user_id"] = nil
  redirect "/"
end

get "/users/create-account" do
  if session['user_id'] != nil
    redirect "/"
  else
    erb :"/users/create-account"
  end

end

post "/users/create-account" do
  @user =  User.new(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], password: params[:password], dob: params[:dob])
  @user.save
  session[:user_id] = @user.id
  redirect "/users/#{@user.id}"
end

get "/users/:id" do
  @user = User.find(params["id"])
  erb :"/users/user-profile"
end

get "/users/?" do
  @user = User.all
  erb :"/users/user-profile"
end

post "/users/:id" do
  @user =  User.find(params["id"])
  @user.destroy
  session["user_id"] = nil
  redirect "/"
end

####################Article##############################
get "/articles/create-article" do
  if session['user_id'] == nil
    redirect '/'
    end
  erb :"/articles/create-article"
end

post "/articles/create-article" do
  @article = Article.new(title: params[:title], content: params[:content], image: params[:image], user_id: session[:user_id])
  @article.save
  redirect "/articles/#{@article.id}"
end

get "/articles/:id" do
  @article =  Article.find(params["id"])
  erb :"/articles/article-content"
end

get "/articles/?" do
  @article = Article.all
  erb :"/articles/articles-page"
end

post "/articles/:id" do
  @article =  Article.find(params["id"])
  @article.destroy

  redirect "/articles/"
end

get "/dashboard" do
  @all_articles = Article.last(20)

  erb :dashboard
end
