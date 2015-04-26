Rails.application.routes.draw do
  devise_for :users
  root 'application#welcome'
end
