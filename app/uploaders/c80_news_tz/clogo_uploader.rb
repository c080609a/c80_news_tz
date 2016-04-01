# грузит лого компании
module C80NewsTz
  class ClogoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    process :resize_to_limit => [500,500]

      version :thumb_fit do
      process :resize_to_fit => [124,124]
    end

    version :thumb_fill do
      process :resize_to_fill => [124,74]
    end

    version :thumb_preview_small do
      process :resize_to_fit => [80, 44]
    end

    version :thumb_preview_medium do
      process :resize_to_fit => [80, 44]
    end

    # идёт в блок "главная публикация", что на главной
    version :thumb_preview_big do
      process :resize_to_fit => [124, 124]
    end

    # идёт в блок в списке партнёров на странице "партнёры"
    version :thumb_preview_list do
      process :resize_to_w223
      #process :resize_to_fit => [223, 310]
    end

    # выдать актуальную ширину\высоту thumb_preview_list
    def thumb_preview_list_wh
      image = ::MiniMagick::Image.open(model.logo.thumb_preview_list.current_path)
      [image["width"], image["height"]]
    end

    def store_dir
      "uploads/companies/_logos/#{format("%02d", model.id)}"
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def filename
      if original_filename
        "logo_#{secure_token(4)}.#{file.extension}"
      end
    end

    protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end

    private

    # NB:: подгон под ширину preview image в pub_medium
    def resize_to_w223
      manipulate! do |img|
        w = 223
        h = calc_height_of_image(w)
        img.resize "#{w}x#{h}>"
        img = yield(img) if block_given?
        img
      end
    end

    def calc_height_of_image(w)
      model_image = ::MiniMagick::Image.open(model.logo.current_path)
      calc_height(w, model_image["width"], model_image["height"])
    end

    # подгоняем по ширине, рассчитываем высоту
    def calc_height(width, original_w, original_h)
      k = width.to_f/original_w
      original_h * k
    end

  end

end