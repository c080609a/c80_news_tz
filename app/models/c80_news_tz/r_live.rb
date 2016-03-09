# Активный рекламодатель
module C80NewsTz
  class RLive < ActiveRecord::Base
    has_and_belongs_to_many :r_advertisers, :join_table => 'c80_news_tz_advs_lives'
  end
end
