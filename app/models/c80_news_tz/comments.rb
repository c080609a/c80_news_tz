module C80NewsTz
  class Comment < ActiveRecord::Base
    validates_with CommentValidator
    belongs_to :fact
    belongs_to :r_blurb
    belongs_to :user

    before_create :set_user_name

    def answers
      []
    end

    def blurb_or_fact
      if fact.present?
        fact
      else
        r_blurb
      end
    end

    private

    def set_user_name
      self.user_name = user.name
    end

  end
end