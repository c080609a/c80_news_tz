include ActionView::Helpers::SanitizeHelper
require "babosa"

module C80NewsTz
  class Company < ActiveRecord::Base
    has_many :galleries, :dependent => :destroy
    accepts_nested_attributes_for :galleries,
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
    has_many :cphotos, :dependent => :destroy
    accepts_nested_attributes_for :cphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_companies_facts'
    has_and_belongs_to_many :notices, :join_table => 'c80_news_tz_companies_notices'

    mount_uploader :logo, LogoUploader

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

    def desc_short
      result = ''

      if desc.present?
        d = desc.gsub!(/\[\[\d\]\]/, '')
        if d.nil?
          d = desc
        end
        result = strip_tags(d)[0..100]
      end

      result
    end

  end
end