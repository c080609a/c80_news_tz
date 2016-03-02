module C80NewsTz
  class FactValidator < ActiveModel::Validator
    def validate(record)

      unless record.title.present?
        record.errors[:title] = 'Название публикации не может быть пустым'
      end

      # unless record.short.present?
      #   record.errors[:short] = 'Заполните краткое описание публикации'
      # end

      unless record.full.present?
        record.errors[:full] = 'Текст публикации не может быть пустым'
      end

    end
  end
end