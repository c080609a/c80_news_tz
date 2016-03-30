require "babosa"
include ActionView::Helpers::SanitizeHelper

# публикация рекламодателя
module C80NewsTz
  class RBlurb < ActiveRecord::Base
    has_and_belongs_to_many :issues, :join_table => 'c80_news_tz_facts_issues'
    has_many :r_bphotos, :dependent => :destroy
    accepts_nested_attributes_for :r_bphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true

    has_and_belongs_to_many :issues, :join_table => 'c80_news_tz_blurbs_issues'
    has_and_belongs_to_many :rubrics, :join_table => 'c80_news_tz_blurbs_rubrics'
    has_and_belongs_to_many :r_advertisers, :join_table => 'c80_news_tz_advs_blurbs'
    has_many :comments, :dependent => :destroy

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

      if full.present? && full.length > 0
        result = strip_tags(full[0..200]+"...")
      else
        result = nil
      end
      result

    end

    # выдать публикации, принадлежащие указанной рубрике
    def self.where_rubric(rubric_slug)
      self.joins(:rubrics).where(:c80_news_tz_rubrics => {:slug => rubric_slug})
    end

    # выдать массив с двумя последними публикациями указанного рекламодателя
    # массив может содержать элементов: 0, 1, 2
    def self.two_last_pubs_by_advr(advertiser_id)
      s = "
        SELECT
          `c80_news_tz_r_blurbs`.*
        FROM
          `c80_news_tz_r_blurbs`
        INNER JOIN
          `c80_news_tz_advs_blurbs` ON `c80_news_tz_r_blurbs`.id = `c80_news_tz_advs_blurbs`.r_blurb_id
        WHERE
          `c80_news_tz_advs_blurbs`.r_advertiser_id = #{advertiser_id}
        ORDER BY
          `c80_news_tz_r_blurbs`.created_at DESC
        LIMIT 2;
      "

      result = self.find_by_sql(s)
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

    # выдать id первой попавшейся рубрики
    # если рубрики у публикации нету - выдать невероятное число 999999
    def rubric_id
      result = 999999
      if rubrics.count > 0
        result = rubrics.first.id
      end
      result
    end

    # выдать id первого попавшегося номера
    # если номера у публикации нету - выдать невероятное число 999999
    def issue_id
      result = 999999
      if issues.count > 0
        result = issues.first.id
      end
      result
    end

    # выдать название номера, которому принадлежит новость
    # если чего-то не хватает - выдаётся пустая строка
    def issue_title
      result = ""
      if issues.count > 0
        result = issues.first.number
      end
      result
    end

    # выдать логотип первого попавшегося рекламодателя
    # если чего-то нету - выдаётся nil
    def company_logo
      result = nil
      if r_advertisers.count > 0
        if r_advertisers.first.logo.present?
          result = r_advertisers.first.logo
        end
      end
      result
    end

  end
end