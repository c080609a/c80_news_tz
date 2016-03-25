module C80NewsTz
  class Comment < ActiveRecord::Base
    validates_with CommentValidator
    belongs_to :facts
    belongs_to :r_blurbs
    belongs_to :users
  end
end