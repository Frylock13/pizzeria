class Web::Admin::PizzaCategoriesController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :pizza_category, :pizza_categories

  def edit
    # render :edit if stale? [pizza_category] | layout_resources
  end

  def create
    @pizza_category = PizzaCategory.new(pizza_category_params)
    if @pizza_category.save
      respond_to do |format|
        format.html { redirect_to admin_pizzas_path, success: 'Категория пиццы успешно добавлена' }
        format.json { render json: @pizza_category }
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'error' }, status: 422 }
      end
    end
  end

  def update
    if update_by_reason
      respond_to do |format|
        format.html { redirect_to admin_pizzas_path, success: 'Категория пиццы успешно обновлена' }
        format.json { render json: { message: 'Success' }, status: 200 }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Данные не сохранены'
          render :edit, change: "edit_pizza_category_#{pizza_category.id}", layout: !request.xhr?
        end
        format.json { render json: { errors: pizza_category.errors }, status: 422 }
      end
    end
  end

  def destroy
    if pizza_category.destroy
      flash[:success] = 'Категория успешно удалена'
    else
      flash[:success] = 'Невозможно удалить категорию'
    end
    redirect_to admin_pizzas_path, change: :pizzas
  end

  private

  def menu_key
    @menu_key = :pizzas
  end

  def update_by_reason
    if pizza_category_params[:position] != pizza_category.position
      pizza_category.insert_at pizza_category_params[:position].to_i
    end
    pizza_category.update(pizza_category_params)
  end

  def pizza_category
    @pizza_category ||= PizzaCategory.find(params[:id])
  end

  def pizza_categories
    @pizza_categories ||= PizzaCategory.includes(:pizzas).all.order(:position)
  end

  def pizza_category_params
    params.require(:pizza_category).permit(:name, :position)
  end
end
