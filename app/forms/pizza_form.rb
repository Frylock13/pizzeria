class PizzaForm < ActiveForm
  attribute :dough_id, Integer
  attribute :image
  attribute :name, String
  attribute :owner, Profile
  attribute :parent, Pizza
  attribute :parent_id, Integer
  attribute :pizza, Pizza
  attribute :pizza_attributes
  attribute :pizza_ingredients
  attribute :pizza_ingredients_attributes
  attribute :visibility, Integer, default: :for_user

  validates :dough_id, :pizza_ingredients_attributes, presence: true

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Pizza')
  end

  def build
    build_parent
    build_pizza
    build_image
    build_name
    build_owner
    build_visibility
    build_dough_id
    build_pizza_attributes
    build_pizza_ingredients
    recalculate
    self
  end

  def build_parent
    self.parent = Pizza.standard.find_by(id: parent_id)
  end

  def build_pizza
    if parent.present?
      self.pizza = parent.deep_clone include: [:pizza_ingredients, :pizza_attributes], except: [:owner_id]
      pizza.parent = parent
    else
      self.pizza = Pizza.new
    end
  end

  def build_image
    self.image = pizza.image
  end

  def build_name
    pizza.name = parent.present? ? "#{pizza.name} особая" : "Уникальная"
    self.name = pizza.name
  end

  def build_owner
    pizza.owner = owner
  end

  def build_visibility
    pizza.visibility = visibility
  end

  def build_dough_id
    if self.dough_id.present?
      pizza.dough_id = self.dough_id
    else
      self.dough_id = pizza.dough_id
    end
  end

  def build_pizza_attributes
    unless parent.present?
      PizzaSizes.pizza_size.values.each { |value| pizza.pizza_attributes.build(pizza_size: value) }
    end
    self.pizza_attributes = pizza.pizza_attributes
  end

  def build_pizza_ingredients
    if pizza_ingredients_attributes.present?
      pizza.pizza_ingredients = []
      pizza_ingredients_attributes.each { |key, value| pizza.pizza_ingredients.build(value) }
    end
    self.pizza_ingredients = pizza.pizza_ingredients
  end

  def recalculate
    PizzaRecalculatingService.new(pizza).recalculate
    self.pizza_attributes = pizza.pizza_attributes
  end

  private

  def persist_data
    pizza.save
  end
end
