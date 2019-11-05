class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  version :thumb do 
   process resize_to_fit: [300, 300] 
 end 
version :thumb50 do 
  process resize_to_fit: [200, 200] 
 end 
  def size_range
    1..10.megabytes
  end
  
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end
  
  def store_dir
    "uploads/{user.class.to_s.underscore}/{image}/{user.id}"
  end

  def extension_whitelist
    %w(png jpg)
  end

  def filename
    original_filename if original_filename
  end

  
end
