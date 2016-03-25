module C80NewsTz
  class CommentValidator < ActiveModel::Validator
    def validate(record)
      unless record.message.present?
        record.errors[:message] = 'Сообщение не может быть пустым.'
      end
    end
  end
end