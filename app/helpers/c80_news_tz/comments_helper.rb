module C80NewsTz
  module CommentsHelper

    # рендер блока с комментариями к публикации
    def render_comments_block(blurb_or_fact, current_user = nil)

      n = blurb_or_fact.comments.count
      # list = [
      #     {id: 12,
      #      parent_id: 0,
      #      user_name: 'Иван Николаевич',
      #      time_published: '28 Март 2016 в 13:40',
      #      user_profile_url: '/',
      #      user_avatar_url: 'https://habrastorage.org/getpro/habr/avatars/97b/8ed/8d6/97b8ed8d6a0d24783dedb33192aeb604_small.jpg',
      #      message: "все по поводу той же производительности ssd дисков.",
      #      answers: [
      #          {id: 22,
      #           parent_id: 12,
      #           user_name: 'Николай',
      #           time_published: '28 Март 2016 в 15:15',
      #           user_profile_url: '/',
      #           user_avatar_url: 'https://habrastorage.org/getpro/habr/avatars/a0b/46e/dfa/a0b46edfa07bca1309a04541cde4cd1a.jpg',
      #           message: "Кажется, ваш стэнд мы видели на NextCastleParty. Очень рад за вас, так держать."
      #          },
      #          {id: 23,
      #           parent_id: 12,
      #           user_name: 'Sample Dark',
      #           time_published: '28 Март 2016 в 15:45',
      #           user_profile_url: '/',
      #           user_avatar_url: 'https://habrastorage.org/getpro/habr/avatars/0f0/a62/41f/0f0a6241fb94bacfd568f0df071ce01a_small.jpg',
      #           message: "Бизнес суров, а игры — особенно применительно к теме краудфандинга — товар, который мы должны продать как можно большему числу людей."
      #          }
      #      ]
      #     },
      #     {id: 13,
      #      parent_id: 0,
      #      user_name: 'Sample Dark',
      #      time_published: '28 Март 2016 в 13:45',
      #      user_profile_url: '/',
      #      user_avatar_url: 'https://habrastorage.org/getpro/habr/avatars/43e/9b4/de5/43e9b4de535dc4d0477313f70c63a4d2_small.jpg',
      #      message: "Вот, например, большой открытый проект на 2.0: https://www.humhub.org/en",
      #      answers: []
      #     }
      #
      # ]

      list = blurb_or_fact.comments

      if blurb_or_fact.is_a?(Fact)
        r_blurb_id = -1
        fact_id = blurb_or_fact.id
      else
        r_blurb_id = blurb_or_fact.id
        fact_id = -1
      end

      render :partial => "c80_news_tz/comments/shared/comments_block",
             :locals => {
                 :comments_count => n,
                 :comments_list => list,
                 :form_params => {
                    :current_user => current_user,
                    :r_blurb_id => r_blurb_id,
                    :fact_id => fact_id
                 }
             }
    end

    # рендер списка комментариев
    def render_comments_list(list)
      render :partial => 'c80_news_tz/comments/shared/comments_list',
             :locals => {
                 :list => list
             }
    end

    # рендер одного комментария (в списке)
    def render_comment_item(comment)
      render :partial => "c80_news_tz/comments/shared/comment_item",
             :locals => {
                 comment: comment
             }
    end

    # рендер формы либо отправки комментария, либо ответа на комментарий
    def render_comment_form(options)
      unless options[:current_user].nil?
        render :partial => "c80_news_tz/comments/shared/reply_comment_form",
               :locals => {
                   current_user_id: options[:current_user].id,
                   r_blurb_id: options[:r_blurb_id],
                   fact_id: options[:fact_id]
               }
      end
    end

  end
end
