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

  end
end