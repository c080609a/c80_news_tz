
module C80NewsTz
  module ApplicationHelper

    include LocalTimeHelper

    def render_news_block(is_news_page=false,page=1)


      if is_news_page
        per_page = C80NewsTz::Prop.first.per_page
        news = Fact.paginate(:page => page,:per_page => per_page)
      else
        per_widget = C80NewsTz::Prop.first.per_widget
        news = Fact.limit(per_widget)
      end

      render :partial => "shared/news_block",
             :locals => {
                 :news_list => news,
                 :is_news_page => is_news_page
             }
    end

    def render_one_fact(fact)
      render :partial => "shared/fact",
             :locals => {
                 fact: fact
             }
    end

    def url_for_fact(fact)
      "news/#{fact.slug}"
    end

    def apph_url_for_rubric(rubric_slug)
      "rubrics/#{rubric_slug}"
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
