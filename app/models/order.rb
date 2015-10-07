class Order
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :phone, :name, :street, :build, :flat, :floor, :intercom, :comment, :booking_date, :payment_type

  validates_presence_of :phone, :name, :street, :build

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
