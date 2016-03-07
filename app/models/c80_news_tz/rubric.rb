require "babosa"
module C80NewsTz
  class Rubric < ActiveRecord::Base
    has_and_belongs_to_many :spots, :join_table => 'c80_news_tz_rubrics_spots'

    validates_with RubricValidator

    extend FriendlyId
    friendly_id :title, use: :slugged

    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    def slug_candidates
      [:title] + Array.new(6) { |index| [:title, index+2] }
    end

    has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_facts_rubrics'

    def should_generate_new_friendly_id?
      slug.blank?
      # name_changed? || super
    end

  end
end
