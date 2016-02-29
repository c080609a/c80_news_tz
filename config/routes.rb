C80NewsTz::Engine.routes.draw do
  match 'news_guru', :to => 'application#guru', :via => :post
end
