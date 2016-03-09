# баннер в самом верху страницы
module C80NewsTz
  class Banner01 < ActiveRecord::Base
    mount_uploader :image, Bimage01Uploader
  end
end