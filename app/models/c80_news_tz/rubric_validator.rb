module C80NewsTz
  class RubricValidator < ActiveModel::Validator
    def validate(record)
      puts '<RubricValidator.validate>'

      if record.title.blank?
        record.errors[:title] = 'Укажите, пожалуйста, название рубрики'
      else
        may_be_pages = Rubric.where(:title => record.title)
        # Rails.logger.info("<RubricValidator.validate> #{may_be_pages[0].id} vs #{record.id}")
        if may_be_pages.count > 0 && may_be_pages[0].id != record.id
          record.errors[:title] = 'Рубрика с таким названием уже существует'
        end
      end

    end
  end
end