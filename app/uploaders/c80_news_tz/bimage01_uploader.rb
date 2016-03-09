# грузит картинку для баннера, который находится в самом верху страницы
module C80NewsTz
  class Bimage01Uploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    process :resize_to_limit => [1200,1200]

    version :thumb_preview do
      process :resize_to_fill => [240,33]
    end

    version :thumb_fill do
      process :resize_to_fill => [1200, 165]
    end

    version :thumb_fit do
      process :resize_to_fit => [1200, 165]
    end

    def store_dir
      "uploads/n_01/#{format("%02d", model.id)}"
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

  end
end