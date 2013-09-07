# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type

  version :thumb, :if => :images? do 
    process :resize_to_fit => [64, 64]
  end

  version :preview, :if => :images? do 
    process :resize_to_fit => [40, 40]
  end

  version :small, :if => :images? do 
    process :resize_to_fit => [200, 200]
  end

  protected

  def images?(new_file)
    new_file.content_type.include? 'image'  
  end
end
