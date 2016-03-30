module C80NewsTz
  module PublicationsHelper

    # собрать информацию для отрисовки preview блока публикации
    def arrange_preview_pub(pub, thumb_size = 'medium')

      # Определимся с размерами области под preview картинки.
      size = calc_thumb_size(thumb_size)
      ww = size[0]
      hh = size[1]

      # определяемся с preview картинкой
      photo_preview = 'nil.gif'
      if pub.photo_preview.present?

        if thumb_size == 'big'
          photo_preview = pub.photo_preview.thumb_preview_big
        elsif thumb_size == 'small'
          photo_preview = pub.photo_preview.thumb_preview_small
        else
          # по умолчанию - возьмем среднюю
          photo_preview = pub.photo_preview.thumb_preview_medium
        end

      end

      # options hash для отрисовки preview image главной публикации
      pi = {
          :alt_image => pub.title,
          :image => photo_preview,
          :ww => ww,
          :hh => hh,
          :a_href => url_for_fact(pub)
      }

      # соберём характеристики компании главной публикации
      cl = nil
      company_logo_image = nil
      company_url = ''
      company_alt = ''

      # определяемся с картинкой логотипа компании
      if pub.company_logo.present?
        # company_logo_image = pub.company_logo.thumb_fit

        if thumb_size == 'big'
          company_logo_image = pub.company_logo.thumb_preview_big
        elsif thumb_size == 'small'
          company_logo_image = pub.company_logo.thumb_preview_small
        else
          # по умолчанию - возьмем среднюю
          company_logo_image = pub.company_logo.thumb_preview_medium
        end

      end

      if company_logo_image.present?
        # вешаем ссылку на компанию на логотип компании
        if pub.companies.count > 0
          company_url = apph_url_for_company(pub.companies.first.slug)
          company_alt = pub.companies.first.title
        end

        # options hash для отрисовки логотипа компании главной публикации
        cl = {
            :alt_image => company_alt,
            :image => company_logo_image,
            :a_href => company_url,
            :a_class => 'company_logo'
        }
      end

      result = {
          pi: pi, # preview image
          cl: cl, # company logo
          title: pub.title,
          rubric: pub.rubric_title,
          time: local_time(pub[:created_at], format: '%H:%M %d.%m.%Y'),
          comments_count: pub.comments.count,
          href: url_for_fact(pub) # TODO_MY:: используется в _simple_preview_list.html.erb, надо использовать везде
      }

      result

    end

    # выдать информацию для отрисовки preview болванки
    def get_billet_pub(thumb_size = 'medium')

      # Определимся с размерами области под preview картинки.
      size = calc_thumb_size(thumb_size)
      ww = size[0]
      hh = size[1]

      result = {
          pi: { # preview image
                :alt_image => 'Укажите публикацию',
                :image => 'nil.gif',
                :ww => ww,
                :hh => hh,
                :a_href => '/'
          },
          cl: nil,
          title: 'На этом месте должна быть публикация',
          rubric: 'Какая такая рубрика?',
          time: '12:30 17.08.1998',
          comments_count: 666
      }
      result
    end

    private

    # В зависимости от thumb_size выдать размер картинки для preview блока публикации
    def calc_thumb_size(thumb_size)
      # Размеры бывают трёх видов:
      #   * big:    500x321 - главная публикация
      #   * small:  126x84 - публикация в правом блоке (места 2 и 3); также используется в выдаче публикаций рубрик
      #   * medium: 223x149 - публикация в горизонтальном блоке (например: места 4,5,6)
      # Текстовые идентификаторы (TAG) коррелируют с именами thumb_preview_{TAG} загрузчика FphotoUploader

      # по умолчанию - возьмём размер средней картинки
      ww = 223
      hh = 149

      if thumb_size == 'big'
        ww = 500
        hh = 321
      elsif thumb_size == 'small'
        ww = 126
        hh = 84
      end

      [ww,hh]

    end

  end
end