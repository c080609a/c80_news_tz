module C80NewsTz
  class Issue < ActiveRecord::Base
    has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_facts_issues'
    has_and_belongs_to_many :r_blurbs, :join_table => 'c80_news_tz_blurbs_issues'
    has_many :pdfs, :dependent => :destroy
    accepts_nested_attributes_for :pdfs,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
  end
end