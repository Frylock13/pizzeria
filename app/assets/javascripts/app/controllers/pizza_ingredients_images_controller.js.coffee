### @ngInject ###
PizzaIngredientsImagesController = (pizzaIngredientsService) ->

  ingredientEnabled = (ingredient_id) =>
    pizzaIngredientsService.ingredientQuantity(ingredient_id) > 0

  # # # # # # # # # # # # # # # # # # #

  @ingredientEnabled = ingredientEnabled
  return

angular
  .module('app')
  .controller('PizzaIngredientsImagesController', PizzaIngredientsImagesController)
