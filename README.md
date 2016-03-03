# C80NewsTz

This gem adds News, Rubrics, Issues, Companies, Galleries, Notices to site. 
News HABTM Rubrics. News HABTM Issues. News HABTM Companies. Companies has_many Galleries. Companies HABTM Notices.

## Installation

Add this line to your application's Gemfile:

    gem 'c80_news_tz'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install c80_news_tz

Perform migrations:

    $ rake db:migrate

Copy example seed files from `<GEM_FOLDER>\db\seeds\` to `<HOST_PROJECT_FOLDER>\db\seeds\`,
remove `.example` extensions.

Copy seeds.sh.example file:

    cp <GEM_FOLDER>\seeds.sh.example <HOST_PROJECT_FOLDER>\seeds.sh; sudo chmod +x seeds.sh; ./seeds.sh
    
Add the line to application's routes file:

    mount C80NewsTz::Engine => '/'

Add this line to `application.js.coffee`:

    #= require c80_news_tz

Add this line to `application.scss`:

    @import "c80_news_tz/application";

Add this line to `application_controller.rb`:

    helper C80NewsTz::Engine.helpers

This gem uses: ActiveAdmin, Fontawesome. Add this to your `active_admin_custom.scss` file:

    @import "font-awesome";

Add these lines to `routes.rb` (optional):

    get '/companies/:company_slug' => 'site#company'
    get '/news/:fact_slug' => 'site#fact'
    get '/issues/:issue_slug' => 'site#issue'
    get '/notices/:notice_slug' => 'site#notice'
    get '/rubrics/:rubric_slug' => 'site#rubric'

Implement these methods in `site_controller.rb` (optional):
    
    def company
    end
    
    # просмотр новости на отдельной странице
    def fact
      @fact = C80NewsTz::Fact.where(:slug => params[:fact_slug]).first
      @vparams[:page_content] = @fact.full if @fact.full.present?
      @vparams[:body_id] = 'fact'
      add_title @fact.title
      # add_breadcrumb @page.title
      @vparams[:description] = @fact.short_meta_description if @fact.short_meta_description.present?
      override_with_seo
      # найти и подсветить родительский пункт меню
      @vparams[:active_menus] << MenuItem.where(:title => 'Новости').first.id
    end
  
    def issue
      # ...
    end
    
    def notice
      # ...
    end
  
    # просмотр рубрики на отдельной странице
    def rubric
      @rubric = C80NewsTz::Rubric.where(:slug => params[:rubric_slug]).first
      add_title(@rubric.title)
      override_with_seo
    end

Implement corresponding views (optional). For example `views/site/fact.html.erb`:
    
    <h1><%= @fact.title %></h1>
    <%= check_page_art(@vparams[:page_content], @fact.fphotos, @fact.title).html_safe %>

## Available helper methods

    render_news_block
    render_one_fact

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/c80_news_tz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
