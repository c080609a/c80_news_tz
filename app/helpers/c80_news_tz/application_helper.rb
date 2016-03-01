
module C80NewsTz
  module ApplicationHelper

    def url_for_fact(fact)
      "news/#{fact.slug}"
    end

    def apph_url_for_rubric(rubric_slug)
      "#{root_url}rubrics/#{rubric_slug}"
    end

    def apph_url_for_company(company_slug)
      "companies/#{company_slug}"
    end
    
    def apph_url_for_notice(notice_slug)
      "notices/#{notice_slug}"
    end
    
    def apph_url_for_issue(issue_id)
      "issues/#{issue_id}"
    end

  end
end
