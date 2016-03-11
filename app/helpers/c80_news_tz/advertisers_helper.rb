module C80NewsTz
  module AdvertisersHelper

    # собрать информацию для отрисовки логотипа компании в блоке "публикации рекламодателя"
    # отрисовка логотипа происходит с помощью метода render_image_link_lazy_holder
    # если логотипа нет - вернёт nil
    def arrange_logo_for_aapub(advertiser)
      # :alt_image => pub.title,
      # :image => photo_preview,
      # :ww => ww,
      # :hh => hh,
      # :a_href => url_for_fact(pub)

      result = nil

      if advertiser.logo_for_aapub.present?
        result = {
            :alt_image => advertiser.title,
            :image => advertiser.logo_for_aapub,
            :ww => 282,
            :hh => 82,
            :a_href => apph_url_for_advertiser(advertiser.slug)
        }
      end

      result
    end

  end
end