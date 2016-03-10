# грузит картинку для баннера, который находится в рекламной области №2, перед содержимым страницы
module C80NewsTz
  class Bimage02Uploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    process :resize_to_limit => [812,812]

    version :thumb_preview do
      process :resize_to_fill => [406,65]
    end

    version :thumb_fill do
      process :resize_to_fill => [812, 130]
    end

    version :thumb_fit do
      process :resize_to_fit => [812, 130]
    end

    def store_dir
      "uploads/n_02/#{format("%02d", model.id)}"
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