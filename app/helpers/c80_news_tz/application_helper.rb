
module C80NewsTz
  module ApplicationHelper

    def url_for_fact(fact)
      "#{root_url}news/#{fact.slug}"
    end

    def apph_url_for_rubric(rubric_slug)
      "#{root_url}rubrics/#{rubric_slug}"
    end

    def apph_url_for_company(company_slug)
      "#{root_url}companies/#{company_slug}"
    end
    
    def apph_url_for_notice(notice_slug)
      "#{root_url}notices/#{notice_slug}"
    end
    
    def apph_url_for_issue(issue_id)
      "#{root_url}issues/#{issue_id}"
    end

  end
end
