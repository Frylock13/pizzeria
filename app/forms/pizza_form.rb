class PizzaForm < ActiveForm
  attribute :dough_id, Integer
  attribute :image
  attribute :name, String
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
    self.parent = Pizza.standard.find_by(id: parent_id)
    if parent.present?
      pizza = parent.deep_clone include: [:pizza_ingredients, :pizza_attributes], except: [:owner_id]
      self.dough_id = pizza.dough_id
      self.image = pizza.image
      self.name = "#{pizza.name} особая"
      self.pizza_attributes = pizza.pizza_attributes
      self.pizza_ingredients = pizza.pizza_ingredients
    else
      self.name = "Уникальная"
      pizza = Pizza.new
      PizzaSizes.pizza_size.values.each { |value| pizza.pizza_attributes.build(pizza_size: value) }
      self.pizza_attributes = pizza.pizza_attributes
      self.pizza_ingredients = []
    end
    self
  end

  def rebuild
    self.parent = Pizza.standard.find_by(id: parent_id)
    if parent.present?
      self.pizza = parent.deep_clone except: [:dough_id, :owner_id]
      pizza.parent = parent
      # self.image = pizza.image
      # self.name = "#{pizza.name} особая"
    else
      self.pizza = Pizza.new
      # self.name = "Уникальная"
    end
    PizzaSizes.pizza_size.values.each { |value| pizza.pizza_attributes.build(pizza_size: value) }
    pizza.dough_id = dough_id
    pizza_ingredients_attributes.each { |key, value| pizza.pizza_ingredients.build(value) }
    PizzaRecalculatingService.new(pizza).recalculate
    self.pizza_attributes = pizza.pizza_attributes
    self.pizza_ingredients = pizza.pizza_ingredients
    self
  end

  private

  def persist_data
    # ActiveRecord::Base.transaction do
    #   self.pizza = Pizza.create
    #   true
    # end
  end
end
