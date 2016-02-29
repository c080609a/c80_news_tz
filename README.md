# C80NewsTz

This gem adds News, Rubrics, Issues, Companies, Galleries, Notices to site. 
News HABTM Rubrics. News HABTM Issues. News HABTM Companies. Companies has_many Galleries. Companies HABTM Notices.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'c80_news_tz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install c80_news_tz

Execute:

    $ rake db:migrate
    $ ./seeds.sh

## Usage

1) `rake db:migrate`

2) Скопировать example файлы из `db\seeds\`, убрать расширение example.

3) `cp seeds.sh.example seeds.sh; sudo chmod +x seeds.sh; ./seeds.sh`.

4) Add the line to application's routes file:

```
mount C80NewsTz::Engine => '/'
```

5) Add this line to `application.js.coffee`:

```
#= require c80_news_tz
```

6) Add this line to `application.scss`:

```
@import "c80_news_tz/application";
```

7) Add this line to `application_controller.rb`:

```
helper C80NewsTz::Engine.helpers
```

This gem uses: ActiveAdmin, Fontawesome.

Add this to your `active_admin_custom.scss` file:

```scss
@import "font-awesome";
```

## Available helper methods

```
render_news_block
render_one_fact
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/c80_news_tz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
