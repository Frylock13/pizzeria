class Web::Admin::DoughsController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :doughs

  def index
  end

  def new
    @dough = Dough.new
    PizzaSizes.pizza_size.values.each { |value| @dough.dough_attributes.build(pizza_size: value) }
  end

  def edit
    @dough = Dough.find(params[:id])
  end

  def create
    @dough = Dough.new(dough_params)
    if @dough.save
      redirect_to [:edit, :admin, @dough], success: 'Тесто успешно добавлено'
    else
      render :new, change: :new_dough, layout: !request.xhr?
    end
  end

  def update
    @dough = Dough.find(params[:id])
    if @dough.update(dough_params)
      redirect_to [:edit, :admin, @dough], success: 'Тесто успешно обновлено'
    else
      render :edit, change: "edit_dough_#{@dough.id}", layout: !request.xhr?
    end
  end

  def destroy
    @dough = Dough.find(params[:id])
    if @dough.destroy
      flash[:success] = 'Тесто успешно удалено'
    else
      flash[:success] = 'Невозможно удалить тесто'
    end
    redirect_to [:admin, :doughs], change: :doughs
  end

  private

  def menu_key
    @menu_key = :doughs
  end

  def doughs
    @doughs ||= Dough.all.order(:name)
  end

  def dough_params
    params.require(:dough).permit(
      :name,
      dough_attributes_attributes: [:id, :pizza_size, :price, :weight]
    )
  end
end
