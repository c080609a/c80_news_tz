module C80NewsTz
  module SubjHelper

    include LocalTimeHelper
    include PageContentHelper # NB:: хардкод: хелпер нах. не внутри гема, а в host приложении. Оформляет lazy-картинки.

    def render_news_block(rubric_slug, page=1)
      per_page = Prop.first.per_page
      news = Fact.where_rubric(rubric_slug).paginate(:page => page,:per_page => per_page)

      news_for_render = []
      news.each do |p|
        news_for_render << arrange_preview_pub(p,'medium')
      end

      render :partial => "shared/news_block",
             :locals => {
                 :news_for_render => news_for_render,
                 :news_list => news,
                 :rubric_slug => rubric_slug
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