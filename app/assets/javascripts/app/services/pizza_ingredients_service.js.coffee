### @ngInject ###
pizzaIngredientsService = ($timeout) ->

  @pizza_ingredients = null
  @submit_to_recalculate_timer = null

  submitToRecalculate = =>
    form = $('#ingredients_fields').closest('form')
    action = form.attr('action')
    if action == '/pizzas'
      form.attr('action', "#{action}/recalculate").submit().attr('action', action)

  runSubmitToRecalculate = =>
    $('#pizza_attributes').ladda().ladda('start')
    $timeout.cancel(@submit_to_recalculate_timer)
    @submit_to_recalculate_timer = $timeout submitToRecalculate, 500

  decreaseIngredient = (ingredient_id) =>
    pizza_ingredient = _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )
    return false unless pizza_ingredient
    return false if pizza_ingredient.quantity == 0
    pizza_ingredient.quantity -= 1
    runSubmitToRecalculate()

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
    runSubmitToRecalculate()

  ingredientQuantity = (ingredient_id) =>
    pizza_ingredient = _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )
    return 0 unless pizza_ingredient
    pizza_ingredient.quantity

  pizzaIngredient = (ingredient_id) =>
    _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )

  init = =>
    @pizza_ingredients = gon.pizza_ingredients

  # # # # # # # # # # # # # # # # # # #

  init()
  return {
    decreaseIngredient: decreaseIngredient
    increaseIngredient: increaseIngredient
    ingredientQuantity: ingredientQuantity
    pizzaIngredient: pizzaIngredient
  }

angular
  .module('app')
  .factory('pizzaIngredientsService', pizzaIngredientsService)
