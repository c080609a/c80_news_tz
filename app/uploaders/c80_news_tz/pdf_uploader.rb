module C80NewsTz
  class PdfUploader < CarrierWave::Uploader::Base

    storage :file

    def extension_white_list
      %w(pdf)
    end

    def filename
      if original_filename
        "file_#{secure_token(4)}.#{file.extension}"
      end
    end

    def store_dir
      "uploads/pdfs/#{model.id}"
    end

    protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end

  end
end