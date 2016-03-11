include ActionView::Helpers::SanitizeHelper
require "babosa"

# рекламодатель
module C80NewsTz
  class RAdvertiser < ActiveRecord::Base

    has_and_belongs_to_many :r_lives, :join_table => 'c80_news_tz_advs_lives'
    has_and_belongs_to_many :r_blurbs, :join_table => 'c80_news_tz_advs_blurbs'

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

    # выдать путь до лого для вставки в блок "публикации рекламодателя"
    # иначе вернёт nil
    def logo_for_aapub
      result = nil
      if logo.present?
        result = logo.thumb_fill
      end
      result
    end

    # выдать активного рекламодателя (он может быть только один)
    # если активного нету - вернётся nil
    def self.active
      result = nil

      s = "
        SELECT
          `c80_news_tz_r_advertisers`.*
        FROM
          `c80_news_tz_r_advertisers`
          INNER JOIN
          `c80_news_tz_advs_lives` ON `c80_news_tz_r_advertisers`.id = `c80_news_tz_advs_lives`.r_advertiser_id;
      "

      array_of_advertisers = self.find_by_sql(s)

      if array_of_advertisers.count == 1
        result = array_of_advertisers[0]
      end

      result

    end

  end
end