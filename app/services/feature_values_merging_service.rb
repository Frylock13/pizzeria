class FeatureValuesMergingService

  attr_accessor :feature_value

  def initialize(feature_value)
    @feature_value = feature_value
  end

  def merge
    feature_values = FeatureValue.where(name: feature_value.name).where.not(id: feature_value.id)
    return nil unless feature_values.any?
    feature_values.each do |merged_feature_value|
      ActiveRecord::Base.transaction do
        merged_feature_value.product_features.update_all(feature_value_id: feature_value.id)
        merged_feature_value.destroy
      end
    end
  end
end
