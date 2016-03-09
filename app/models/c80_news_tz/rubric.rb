require "babosa"
module C80NewsTz
  class Rubric < ActiveRecord::Base
    has_and_belongs_to_many :spots, :join_table => 'c80_news_tz_rubrics_spots'
    has_and_belongs_to_many :facts, :join_table => 'c80_news_tz_facts_rubrics'
    has_and_belongs_to_many :r_blurbs, :join_table => 'c80_news_tz_blurbs_rubrics'

    validates_with RubricValidator

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

    # выдать массив рубрик, которые должны выводиться на главной
    def self.select_all_in_spots
      s = "
        SELECT
          `c80_news_tz_rubrics`.*,
          `c80_news_tz_spots`.`id` AS `spot_id`
        FROM `c80_news_tz_rubrics`
          INNER JOIN `c80_news_tz_rubrics_spots` ON `c80_news_tz_rubrics_spots`.`rubric_id` = `c80_news_tz_rubrics`.`id`
          INNER JOIN `c80_news_tz_spots` ON `c80_news_tz_spots`.`id` = `c80_news_tz_rubrics_spots`.`spot_id`
        ORDER BY `spot_id`;
      "
      result = self.find_by_sql(s)
      result

    end

    # выдать публикации из этой рубрики
    def pubs(lim = nil)
      if lim.nil?
        C80NewsTz::Fact.joins(:rubrics).where(:c80_news_tz_rubrics => {:title => self.title})
      else
        C80NewsTz::Fact.joins(:rubrics).where(:c80_news_tz_rubrics => {:title => self.title}).limit(lim)
      end
    end

  end
end
