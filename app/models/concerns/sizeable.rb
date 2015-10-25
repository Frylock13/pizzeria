module Sizeable
  extend ActiveSupport::Concern

  included do
    enum pizza_size: { d22: 22, d33: 33, d38: 38 }
  end
end
