# Место под рубрику на главной
module C80NewsTz
  class Spot < ActiveRecord::Base
    has_and_belongs_to_many :rubrics, :join_table => 'c80_news_tz_rubrics_spots'
  end
end
