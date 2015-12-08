### @ngInject ###
PizzaIngredientsFormController = (pizzaIngredientsService) ->

  decreaseIngredient = (ingredient_id) =>
    pizzaIngredientsService.decreaseIngredient(ingredient_id)

  increaseIngredient = (ingredient_id) =>
    pizzaIngredientsService.increaseIngredient(ingredient_id)

  ingredientQuantity = (ingredient_id) =>
    pizzaIngredientsService.ingredientQuantity(ingredient_id)

  isBaseControlVisible = (ingredient_id, hide_control = false) =>
    return false unless pizzaIngredient(ingredient_id)
    return false unless ingredientQuantity(ingredient_id) > 0
    return false if hide_control == true
    true

  pizzaIngredient = (ingredient_id) =>
    pizzaIngredientsService.pizzaIngredient(ingredient_id)

  init = =>
    @ingredient_categories = gon.ingredient_categories

  # # # # # # # # # # # # # # # # # # #

  @ingredient_categories = null
  @decreaseIngredient = decreaseIngredient
  @increaseIngredient = increaseIngredient
  @ingredientQuantity = ingredientQuantity
  @isBaseControlVisible = isBaseControlVisible
  @pizzaIngredient = pizzaIngredient
  init()
  return

angular
  .module('app')
  .controller('PizzaIngredientsFormController', PizzaIngredientsFormController)
