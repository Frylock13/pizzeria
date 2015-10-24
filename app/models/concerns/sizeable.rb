module Viewable
  extend ActiveSupport::Concern

  included do
    enum pizza_size: [:d22, :d33, :d38]
  end
end
