module C80NewsTz
  class Nphoto < ActiveRecord::Base
    belongs_to :notice
    mount_uploader :image, NphotoUploader

    # в ~ от размеров thumb-ов и page_content_width - выдать соответствующую картинку
    # • Если у картинки thumb_big шириной ≥ page_content_width - вставляем этот thumb_big.
    # • Иначе: вставлем thumb_small.
    def content_image
      img = MiniMagick::Image.open(image.thumb_big.path)
      w = SiteProp.first.page_content_width
      if img["width"] < w
        image.thumb_small
      else
        image.thumb_big
      end
    end

    # выдать размеры картинки, которая будет вставлена в текст страницы
    def content_image_size
      img = MiniMagick::Image.open(image.thumb_big.path)
      w = SiteProp.first.page_content_width
      if img["width"] < w
        img = MiniMagick::Image.open(image.thumb_small.path)
        [img["width"],img["height"]]
      else
        [img["width"],img["height"]]
      end
    end

  end
end