TinyTim::Application.routes.draw do
  resources :destroys

  #match '/split/gbrug', :to => Split::Dashboard, :anchor => false
  match "/resque/gbrug", :to => Resque::Server, :anchor => false

  resources :users

  root :to => 'users#index'
end
