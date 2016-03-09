include ActionView::Helpers::SanitizeHelper
require "babosa"

# рекламодатель
module C80NewsTz
  class RAdvertiser < ActiveRecord::Base

    # has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_companies_facts'
    has_and_belongs_to_many :r_lives, :join_table => 'c80_news_tz_advs_lives'

    mount_uploader :logo, RAlogoUploader

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