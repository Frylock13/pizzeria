class FeaturesMergingService

  attr_accessor :feature

  def initialize(feature)
    @feature = feature
  end

  def merge
    features = Feature.where(name: feature.name).where.not(id: feature.id)
    return nil unless features.any?
    features.each do |merged_feature|
      ActiveRecord::Base.transaction do
        merged_feature.product_features.update_all(feature_id: feature.id)
        merged_feature.destroy
      end
    end
  end
end
