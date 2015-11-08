### @ngInject ###
PizzaIngredientsFormController = ->

  decreaseIngredient = (ingredient_id) =>
    pizza_ingredient = _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )
    return false unless pizza_ingredient
    return false if pizza_ingredient.quantity == 0
    pizza_ingredient.quantity -= 1

  increaseIngredient = (ingredient_id) =>
    pizza_ingredient = _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )
    if pizza_ingredient
      pizza_ingredient.quantity += 1
    else
      pizza_ingredient =
        ingredient_id: ingredient_id
        quantity: 1
        base: false
      @pizza_ingredients.push pizza_ingredient

  ingredientQuantity = (ingredient_id) =>
    pizza_ingredient = _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )
    return 0 unless pizza_ingredient
    pizza_ingredient.quantity

  pizzaIngredient = (ingredient_id) =>
    _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )

  init = =>
    @ingredient_categories = gon.ingredient_categories
    @pizza_ingredients = gon.pizza_ingredients

  # # # # # # # # # # # # # # # # # # #

  @ingredient_categories = null
  @pizza_ingredients = null
  @decreaseIngredient = decreaseIngredient
  @increaseIngredient = increaseIngredient
  @ingredientQuantity = ingredientQuantity
  @pizzaIngredient = pizzaIngredient
  init()
  return

angular
  .module('app')
  .controller('PizzaIngredientsFormController', PizzaIngredientsFormController)
