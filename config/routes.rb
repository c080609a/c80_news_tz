C80NewsTz::Engine.routes.draw do
  match 'news_guru', :to => 'application#guru', :via => :post
  get '/rubrics/:rubric_slug' => 'site#rubric'
end
