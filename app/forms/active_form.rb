class ActiveForm
  include ActiveModel::Model
  include Virtus.model

  def save
    if valid? && persist_data
      true
    else
      collect_errors
      false
    end
  end

  private

  def collect_errors
    return unless defined?(self.class::RECORDS)
    self.class::RECORDS.each do |record_str|
      record = try(record_str)
      next unless record.present? && record.errors.any?
      record.errors.messages.each do |key, value|
        errors.add(key, value.first)
      end
    end
  end
end
