# баннер в самом верху страницы
module C80NewsTz
  class Banner01 < ActiveRecord::Base
    mount_uploader :image, Bimage01Uploader
    validates_with BannerValidator

    before_save :before_save_format_href

    # выдать рандомный активный баннер
    # если такового нету - вернётся null
    def self.random_active
      result = nil
      a = self.where(:is_active => true)
      if a.count > 0
        b = a.offset(rand(a.count)).first
        if b.image.present?
          result = b
        end
      end
      result
    end

    private

    # каждая ссылка должна начинаться с http://
    def before_save_format_href
      str = 'http://'
      if self.href[0..6] != str
        self.href = "#{str}#{self.href}"
      end
    end

  end
end