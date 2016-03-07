module C80NewsTz
  module SubjHelper

    include LocalTimeHelper

    def render_news_block(rubric_id = nil, page=1)
      per_page = 1#Prop.first.per_page
      news = Fact.paginate(:page => page,:per_page => per_page)

      news_for_render = []
      news.each do |p|
        news_for_render << arrange_preview_pub(p,'medium')
      end

      render :partial => "shared/news_block",
             :locals => {
                 :news_for_render => news_for_render,
                 :news_list => news
             }
    end

    def render_one_fact(fact)
      render :partial => "shared/fact",
             :locals => {
                 fact: fact
             }
    end


  end
end