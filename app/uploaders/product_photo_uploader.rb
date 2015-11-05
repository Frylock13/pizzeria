class ProductPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fit: [1400, 800]

  version :thumb do
    process resize_to_fit: [700, 400]
  end

  def default_url
    ActionController::Base.helpers.asset_path('carrierwave/' + [version_name, 'photo.jpg'].compact.join('_'))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    random_token = Digest::SHA2.hexdigest("#{Time.now.utc}--#{model.id.to_s}").first(20)
    ivar = "@#{mounted_as}_secure_token"
    token = model.instance_variable_get(ivar)
    token ||= model.instance_variable_set(ivar, random_token)
    "#{model.id}_#{token}.jpg" if original_filename
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
