require "babosa"
include ActionView::Helpers::SanitizeHelper

module C80NewsTz
  class Fact < ActiveRecord::Base
    has_and_belongs_to_many :issues, :join_table => 'c80_news_tz_facts_issues'
    has_many :fphotos, :dependent => :destroy
    accepts_nested_attributes_for :fphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true

    has_and_belongs_to_many :rubrics, :join_table => 'c80_news_tz_facts_rubrics'
    has_and_belongs_to_many :companies, :join_table => 'c80_news_tz_companies_facts'
    has_and_belongs_to_many :locations, :join_table => 'c80_news_tz_facts_locations'

    validates_with FactValidator
    default_scope {order(:created_at => :desc)}

    extend FriendlyId
    friendly_id :title, use: :slugged
    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    def slug_candidates
      [:title] + Array.new(6) {|index| [:title, index+2]}
    end

    def short_meta_description

      if description.present? && description.length > 200
        result = description
      elsif full.present? && full.length > 0
        result = strip_tags(full[0..200]+"...")
      else
        result = nil
      end
      result

    end

    # выдать картинку, которая пойдёт в блок преьвю
    def photo_preview
      result = nil
      if fphotos.count > 0
        result = fphotos.first.image
      else
      end
      result
    end

    # выдать строку: title первой попавшейся рубрики
    # если таковой нету - выдаётся пустая строка
    def rubric_title
      result = ""
      if rubrics.count > 0
        result = rubrics.first.title
      end
      result
    end

    # выдать логотип первой попавшейся компании
    # если чего-то нету - выдаётся nil
    def company_logo
      result = nil
      if companies.count > 0
        if companies.first.logo.present?
          result = companies.first.logo
        end
      end
      result
    end

    # выдать массив хэшей: список фактов, находящихся в указанных позициях, отсортированный по location_id
    def self.where_locations(arr_locs_ids)
      # f = C80NewsTz::Fact.joins(:locations).where(:c80_news_tz_locations => {:id => [1,2]})

      s = "
        SELECT
          `c80_news_tz_facts`.*,
          `c80_news_tz_locations`.`id` AS `location_id`
        FROM `c80_news_tz_facts`
          INNER JOIN `c80_news_tz_facts_locations` ON `c80_news_tz_facts_locations`.`fact_id` = `c80_news_tz_facts`.`id`
          INNER JOIN `c80_news_tz_locations` ON `c80_news_tz_locations`.`id` = `c80_news_tz_facts_locations`.`location_id`
        WHERE `c80_news_tz_locations`.`id` IN (#{arr_locs_ids.join(",")})
        ORDER BY `location_id`;
      "

      # result = self.connection.select_all(s)
      result = self.find_by_sql(s)

      result
    end

  end
end