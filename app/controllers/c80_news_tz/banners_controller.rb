module C80NewsTz

  # считает клики по баннерам
  class BannersController < ActionController::Base

    # считает клики по баннерам
    def counter

      # TODO_MY:: реализовать защиту от накручивания, быстрых повторных кликов с того же ip, левых запросов

      # params[:c] = $
      # где строка вида rb{(\d\d)}_{(\d+)}:
      #   $1: часть имени класса баннера
      #   $2: id баннера в базе

      s = params[:c]
      rex = /(?<=rb)(\d\d)_(\d+)/
      result = s[rex]

      if result.present?

        # извлекаем данные
        class_part_name = result[$1]
        banner_id = result[$2]
        Rails.logger.debug("<BannersController.counter> class_part_name = #{class_part_name}, banner_id = #{banner_id}")

        # фиксируем баннер
        b = nil
        if class_part_name == '01'
          b = Banner01.find(banner_id)
        elsif class_part_name == '02'
          b = Banner02.find(banner_id)
        elsif class_part_name == '03'
          # b = Banner03.find(banner_id)
        end

        # увеличиваем счётчик на единицу
        if b.present?
          b.clicks += 1
          b.save!
        end

      end

    end

  end
end