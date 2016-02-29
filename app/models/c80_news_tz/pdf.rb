module C80NewsTz
  class Pdf < ActiveRecord::Base
    belongs_to :issue
    mount_uploader :file, PdfUploader
  end
end