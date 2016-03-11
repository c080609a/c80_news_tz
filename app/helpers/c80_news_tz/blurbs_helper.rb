module C80NewsTz
  module BlurbsHelper

    # собрать информацию для отрисовки preview блока публикации рекламодателя в блоке "публикации рекламодателя"
    def arrange_blurb_preview_for_rblock(blurb)
      result = {
          title: blurb.title,
          time: local_time(blurb[:created_at], format: '%H:%M %d.%m.%Y'),
          href: apph_url_for_blurb(blurb)
      }
    end

  end
end