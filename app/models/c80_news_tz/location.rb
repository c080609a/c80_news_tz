module C80NewsTz
  class Location < ActiveRecord::Base
    has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_facts_locations'
  end
end
