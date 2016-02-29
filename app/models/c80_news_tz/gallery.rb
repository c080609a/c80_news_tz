module C80NewsTz
  class Gallery < ActiveRecord::Base
    belongs_to :company
    belongs_to :notice
    has_many :gphotos, :dependent => :destroy
    accepts_nested_attributes_for :gphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
  end
end
