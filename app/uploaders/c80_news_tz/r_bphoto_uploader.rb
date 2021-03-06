# грузит картинки, вставляемые в текст публикаций рекламодателей
module C80NewsTz
  class RBphotoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    # При загрузке картинок генерим два thumb:
    #   - thumb_big (resize_to_limit),
    #   - thumb_small (resize_to_limit: w = page_content*1/3).

    version :thumb_big do
      process :resize_to_limit_big
    end

    version :thumb_small do
      process :resize_to_limit_small
    end

    version :thumb_preview_small do
      process :resize_to_fill => [126, 84]
    end

    version :thumb_preview_medium do
      process :resize_to_fill => [223, 149]
    end

    # идёт в блок "главная публикация", что на главной
    version :thumb_preview_big do
      process :resize_to_fill => [500, 321]
    end

    def store_dir
      "uploads/rec/blurbs/#{format("%02d", model.r_blurb_id)}"
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def filename
      if original_filename
        "photo_#{secure_token(4)}.#{file.extension}"
      end
    end

    protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end


    def resize_to_limit_big
      # puts "<PageArtUploader.resize_to_limit_big>"
      manipulate! do |img|

        w = SiteProp.first.page_content_width
        h = calc_height_of_image(w)

        img.resize "#{w}x#{h}>"
        img = yield(img) if block_given?
        img

      end
    end

    def resize_to_limit_small
      # puts "<PageArtUploader.resize_to_limit_small>"
      manipulate! do |img|

        w = SiteProp.first.page_content_width/3
        h = calc_height_of_image(w)

        img.resize "#{w}x#{h}>"
        img = yield(img) if block_given?
        img

      end
    end

    private

    def calc_height_of_image(w)
      model_image = ::MiniMagick::Image.open(model.image.current_path)
      calc_height(w, model_image["width"], model_image["height"])
    end

    # подгоняем по ширине, рассчитываем высоту
    def calc_height(width, original_w, original_h)
      k = width.to_f/original_w
      original_h * k
    end


  end
end