Dailytask::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations", :passwords=> "passwords" }

  root :to => "application#index"
  get "/:username" => "tweets#index", :constraints => { :username => /[^\/]+(?=\.html\z|\.json\z|\.ico\z)|[^\/]+/ }
  post "/tweets" => 'tweets#create'
  get "/tweets/:id/retweet" => 'tweets#retweet'
  get "/tweets/:id/:type" => 'tweets#change'
  delete "/tweets/:id" => 'tweets#destroy'
  get "/:username/following" => "followers#following", :constraints => { :username => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  get "/:username/follower" => "followers#follower", :constraints => { :username => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }
  post "/follow/:id" => "followers#follow"
  delete "/unfollow/:id" => "followers#destroy"
end
