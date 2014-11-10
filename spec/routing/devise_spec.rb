require 'spec_helper'
describe "routing test" do
  it "routes /users/sign_up to RegistrationsController#new for signup" do
    expect(:get => "/users/sign_up").to route_to(
      :controller => "registrations",
      :action => "new"
    )
  end

  it "routes /users/edit to RegistrationsController#edit for edit" do
    expect(:get => "/users/edit").to route_to(
                                            :controller => "registrations",
                                            :action => "edit"
                                        )
  end

  it "routes /users to RegistrationsController#create for post" do
    expect(:post => "/users").to route_to(
                                    :controller => "registrations",
                                    :action => "create"
                                )
  end

  it "routes /users/cancel to RegistrationsController#cancel for cancel" do
    expect(:get => "/users/cancel").to route_to(
                                     :controller => "registrations",
                                     :action => "cancel"
                                 )
  end

  it "routes /users to RegistrationsController#update for put" do
    expect(:put => "/users").to route_to(
                                         :controller => "registrations",
                                         :action => "update"
                                     )
  end

  it "routes /users to RegistrationsController#destroy for delete" do
    expect(:delete => "/users").to route_to(
                                    :controller => "registrations",
                                    :action => "destroy"
                                )
  end

  it "routes /users/sign_in to SessionsController#new for signin" do
    expect(:get => "/users/sign_in").to route_to(
      :controller => "sessions",
      :action => "new"
    )
  end

  it "routes /users/sign_in to SessionsController#create for signin" do
    expect(:post => "/users/sign_in").to route_to(
      :controller => "sessions",
      :action => "create"
    )
  end

  it "routes /users/sign_out to SessionsController#destroy for signout" do
    expect(:delete => "/users/sign_out").to route_to(
      :controller => "sessions",
      :action => "destroy"
    )
  end

  it "routes /users/sign_out to SessionsController#destroy for signout" do
    expect(:get => "/").to route_to(:controller => "application",:action => "index")
  end

  it "routes /users/password/new to PasswordsController#new for new" do
    expect(:get => "/users/password/new").to route_to(
                                            :controller => "passwords",
                                            :action => "new"
                                        )
  end

  it "routes /users/password/edit to PasswordsController#edit for edit" do
    expect(:get => "/users/password/edit").to route_to(
                                                 :controller => "passwords",
                                                 :action => "edit"
                                             )
  end

  it "routes /users/password to PasswordsController#create for post" do
    expect(:post => "/users/password").to route_to(
                                                  :controller => "passwords",
                                                  :action => "create"
                                              )
  end

  it "routes /users/password to PasswordsController#update for put" do
    expect(:put => "/users/password").to route_to(
                                              :controller => "passwords",
                                              :action => "update"
                                          )
  end

  it "routes /testuser to TweetsController#index for get" do
    expect(:get => "/testuser").to route_to(
                                             :controller => "tweets",
                                             :action => "index",
                                             :username=>"testuser"
                                         )
  end

  it "routes /tweets to TweetsController#create for post" do
    expect(:post => "/tweets").to route_to(
                                       :controller => "tweets",
                                       :action => "create"
                                   )
  end

  it "routes /tweets/1/public to TweetsController#change for get" do
    expect(:get => "/tweets/1/public").to route_to(
                                      :controller => "tweets",
                                      :action => "change",
                                      :id=>"1",
                                      :type=>"public"
                                  )
  end

  it "routes /tweets/1/retweet to TweetsController#retweet for get" do
    expect(:get => "/tweets/1/retweet").to route_to(
                                              :controller => "tweets",
                                              :action => "retweet",
                                              :id=>"1"
                                          )
  end

  it "routes /tweets/1 to TweetsController#destroy for delete" do
    expect(:delete => "/tweets/1").to route_to(
                                       :controller => "tweets",
                                       :action => "destroy",
                                       :id=>"1"
                                   )
  end

  it "routes /testuser/following to FollowersController#following for get" do
    expect(:get => "/testuser/following").to route_to(
                                          :controller => "followers",
                                          :action => "following",
                                          :username=>"testuser"
                                      )
  end

  it "routes /testuser/follower to FollowersController#follower for get" do
    expect(:get => "/testuser/follower").to route_to(
                                                    :controller => "followers",
                                                    :action => "follower",
                                                    :username=>"testuser"
                                                )
  end


  it "routes /follow/1 to FollowersController#follow for post" do
    expect(:post => "/follow/1").to route_to(
                                                   :controller => "followers",
                                                   :action => "follow",
                                                   :id=>"1"
                                               )
  end

  it "routes /unfollow/1 to FollowersController#destroy for delete" do
    expect(:delete => "/unfollow/1").to route_to(
                                        :controller => "followers",
                                        :action => "destroy",
                                        :id=>"1"
                                    )
  end

end