C80NewsTz::Engine.routes.draw do
  match 'news_guru', :to => 'application#guru', :via => :post
  match 'rb', :to => 'banners#counter', :via => :post

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :comments, :only => :create

end
