module C80NewsTz
  class BannerValidator < ActiveModel::Validator
    def validate(record)
      unless record.title.present?
        record.errors[:title] = 'Укажите название'
      end
      unless record.href.present?
        record.errors[:href] = 'Укажите ссылку'
      end
      unless record.image.present?
        record.errors[:image] = 'Загрузите картинку'
      end
      puts record.errors.as_json
    end
  end
end