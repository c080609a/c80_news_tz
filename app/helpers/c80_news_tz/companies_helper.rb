module C80NewsTz
  module CompaniesHelper

    # рендер списка компаний
    def render_companies_list(page = 1, per_page = 8)

      # NB:: передаём в партиал два списка:
      # NB::  - один: непосредственно для ренедра
      # NB::  - другой: вспомогательный, для передачи в виде аргумента в will_paginate

      companies = Company.paginate(page: page, per_page: per_page)
      companies_list = arrange_companies_list(companies)

      render :partial => 'c80_news_tz/companies/shared/companies_list',
             :locals => {
                 companies_for_render: companies_list,
                 companies: companies
             }
    end

    private

    # подготовить данные для рендера списка компаний во view
    def arrange_companies_list(companies)
      result = []
      companies.each do |company|
        wh = company.logo.thumb_preview_list_wh
        result << {
            title: company.title,
            activity_type: company.activity_type,
            href: apph_url_for_company(company.slug),
            pubs_count: company.facts.count,
            desc_short: company.desc_short,
            logo: {
                :alt_image => company.title,
                :image => company.logo.thumb_preview_list,
                :ww => wh[0],
                :hh => wh[1],
                :a_href => apph_url_for_company(company.slug),
                :a_class => 'preview_image'
            }
        }

      end
      result
    end

  end
end