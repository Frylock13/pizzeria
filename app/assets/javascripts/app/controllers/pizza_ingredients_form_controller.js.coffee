### @ngInject ###
PizzaIngredientsFormController = ($timeout) ->

  submitToRecalculate = =>
    form = $('#ingredients_fields').closest('form')
    action = form.attr('action')
    form.attr('action', "#{action}/recalculate").submit().attr('action', action) if action == '/pizzas'

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

  isBaseControlVisible = (ingredient_id, hide_control = false) =>
    return false unless pizzaIngredient(ingredient_id)
    return false unless ingredientQuantity(ingredient_id) > 0
    return false if hide_control == true
    true

  pizzaIngredient = (ingredient_id) =>
    _.findWhere( @pizza_ingredients, { ingredient_id: ingredient_id } )

  init = =>
    @ingredient_categories = gon.ingredient_categories
    @pizza_ingredients = gon.pizza_ingredients

  # # # # # # # # # # # # # # # # # # #

  @submit_to_recalculate_timer = null
  @ingredient_categories = null
  @pizza_ingredients = null
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
