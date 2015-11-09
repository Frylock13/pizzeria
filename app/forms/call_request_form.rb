class CallRequestForm < ActiveForm
  attribute :first_name
  attribute :phone
  attribute :wishes
  attribute :ordering_profile, Profile

  validates :first_name, :phone, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, 'CallRequest')
  end

  def build
    self.first_name = ordering_profile.first_name
    self.phone = ordering_profile.phone
    self
  end

  private

  def persist_data
    ActiveRecord::Base.transaction do
      call_request = CallRequest.create(wishes: wishes,
                                        ordering_profile: get_ordering_profile,
                                        receiving_profile: get_receiving_profile)
      true
    end
  end

  def get_ordering_profile
    if ordering_profile.new_record? || profile_empty?(ordering_profile)
      ordering_profile.update(first_name: first_name, phone: phone)
    end
    ordering_profile
  end

  def get_receiving_profile
    if ordering_profile.first_name != first_name || ordering_profile.phone != phone
      Profile.create(first_name: first_name, phone: phone)
    else
      ordering_profile
    end
  end

  def profile_empty?(profile)
    profile.first_name.nil? && profile.phone.nil?
  end
end
