module Viewable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    has_one :viewable_resource, as: :viewable
    delegate :meta_title, :meta_keywords, :page_title, :page_annotation, :page_description,
             :anchor, to: :viewable_resource, allow_nil: true
    friendly_id :meta_title, use: [:slugged, :history, :finders]
    accepts_nested_attributes_for :viewable_resource, allow_destroy: true
    validates :slug, uniqueness: true
  end
end
