C80NewsTz::Engine.routes.draw do
  match 'news_guru', :to => 'application#guru', :via => :post
  match 'rb', :to => 'banners#counter', :via => :post
end
