# грузит лого рекламодателя
module C80NewsTz
  class RAlogoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage :file

    process :resize_to_limit => [500,500]



    # вставляются в блок "публикации рекламодателя"
    version :thumb_fit do
      process :resize_to_fit => [282,82]
    end

    version :thumb_fill do
      process :resize_to_fill => [282,82]
    end



    # по идее, должны вставляться в preview блока новости
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




    def store_dir
      "uploads/rec/avs/_logos/#{format("%02d", model.id)}"
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


  end

end