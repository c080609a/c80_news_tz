require "babosa"
module C80NewsTz
  class Notice < ActiveRecord::Base
    has_one :gallery, :dependent => :destroy
    accepts_nested_attributes_for :gallery,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_one :adress, :dependent => :destroy
    accepts_nested_attributes_for :adress,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_many :nphotos, :dependent => :destroy
    accepts_nested_attributes_for :nphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_and_belongs_to_many :companies, :join_table => 'c80_news_tz_companies_notices'

    extend FriendlyId
    friendly_id :title, use: :slugged

    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    def slug_candidates
      [:title] + Array.new(6) { |index| [:title, index+2] }
    end

    def should_generate_new_friendly_id?
      slug.blank?
      # name_changed? || super
    end

  end
end