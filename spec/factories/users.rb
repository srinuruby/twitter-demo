# encoding: utf-8
FactoryGirl.define do
  factory :user do
    name                   "Test User"
    email                  "user@example.com"
    password               "password"
    password_confirmation  "password"
    username               "testuser"
  end
end