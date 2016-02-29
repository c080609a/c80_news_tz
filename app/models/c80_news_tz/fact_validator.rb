module C80NewsTz
  class FactValidator < ActiveModel::Validator
    def validate(record)

      unless record.title.present?
        record.errors[:title] = 'Название новости не может быть пустым'
      end

      unless record.short.present?
        record.errors[:short] = 'Заполните краткое описание новости'
      end

      unless record.full.present?
        record.errors[:full] = 'Текст новости не может быть пустым'
      end

    end
  end
end