module Admin
  class PizzasController < AdminController
    before_action :main_menu_key

    def index
      @pizzas = Pizza.all.order(:name)
    end

    def new
      @pizza = Pizza.new
      PizzaAttribute.pizza_sizes.each do |key, value|
        @pizza.pizza_attributes << PizzaAttribute.new(pizza_size: key)
      end
    end

    def edit
      @pizza = Pizza.find(params[:id])
    end

    def create
      @pizza = Pizza.new(pizza_params)
      if @pizza.save
        redirect_to [:edit, :admin, @pizza], success: 'Пицца успешно добавлена'
      else
        render :new, change: :new_pizza, layout: !request.xhr?
      end
    end

    def update
      @pizza = Pizza.find(params[:id])
      if @pizza.update(pizza_params)
        redirect_to [:edit, :admin, @pizza], success: 'Пицца успешно обновлена'
      else
        render :edit, change: "edit_pizza_#{@pizza.id}", layout: !request.xhr?
      end
    end

    private

    def main_menu_key
      @main_menu_key = :pizzas
    end

    def pizza_params
      params.require(:pizza).permit(
        :name, :image, :visibility,
        { pizza_attributes_attributes: [:id, :pizza_size, :price, :weight] }
      )
    end
  end
end
