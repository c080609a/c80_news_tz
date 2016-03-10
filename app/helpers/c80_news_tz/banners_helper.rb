module C80NewsTz
  module BannersHelper

    # рендер баннера в рекламном блоке 1
    def render_banner_01

      # извлечём баннер
      b = Banner01.random_active

      if b.present?

        # увеличим счётчик показов
        b.shown += 1
        b.save!

        # соберём информацию для рендера view
        vp = {
            alt_image: b.title,
            image: b.image.thumb_fill,
            ww: 1200,       # ширина\высота совпадает с шириной\высотой, указанной в Bimage01Uploader
            hh: 165,
            a_href: b.href,
            aid: 'rb01',     # используется js для подсчёта кликов
            a_class: "rb01_#{b.id}"
        }

        render :partial => 'shared/banner_01',
               :locals => {
                   :vp => vp
               }
      end
    end

    # рендер баннера в рекламном блоке 2
    def render_banner_02

      # извлечём баннер
      b = Banner02.random_active

      if b.present?

        # увеличим счётчик показов
        b.shown += 1
        b.save!

        # соберём информацию для рендера view
        vp = {
            alt_image: b.title,
            image: b.image.thumb_fill,
            ww: 812,       # ширина\высота совпадает с шириной\высотой, указанной в Bimage02Uploader
            hh: 130,
            a_href: b.href,
            aid: 'rb02',     # используется js для подсчёта кликов
            a_class: "rb02_#{b.id}"
        }

        render :partial => 'shared/banner_02',
               :locals => {
                   :vp => vp
               }
      end
    end

    # рендер баннера в рекламном блоке 3
    def render_banner_03

      # извлечём баннер
      b = Banner03.random_active

      if b.present?

        # увеличим счётчик показов
        b.shown += 1
        b.save!

        # соберём информацию для рендера view
        vp = {
            alt_image: b.title,
            image: b.image.thumb_fill,
            ww: 287,       # ширина\высота совпадает с шириной\высотой, указанной в Bimage03Uploader
            hh: 321,
            a_href: b.href,
            aid: 'rb03',     # используется js для подсчёта кликов
            a_class: "rb03_#{b.id}"
        }

        render :partial => 'shared/banner_03',
               :locals => {
                   :vp => vp
               }
      end
    end

  end
end