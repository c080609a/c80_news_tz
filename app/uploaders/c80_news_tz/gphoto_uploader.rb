module C80NewsTz
  class GphotoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/gallery/#{format("%03d", model.gallery_id)}"
    end

    # ограничение оригинальной картинки
    process :resize_to_limit => [1024, 1024]

    version :thumb_841 do
      process :resize_to_limit => [841, 672]
    end

    version :thumb_841fill do
      process :resize_to_fill => [841, 672]
    end

    version :thumb_841fit do
      process :resize_to_fit => [841, 672]
    end

    version :thumb_222fill do
      process :resize_to_fill => [222, 176]
    end

    version :thumb_222fit do
      process :resize_to_fit => [222, 176]
    end

    version :thumb_186fill do
      process :resize_to_fill => [186, 133]

    end

    version :thumb_99 do
      process :resize_to_fill => [99, 78]
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

    def extension_white_list
      %w(jpg jpeg gif png)
    end

  end
end
