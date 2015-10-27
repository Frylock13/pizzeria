module Admin
  class DoughsController < AdminController
    before_action :main_menu_key

    def index
      @doughs = Dough.all
      render :index if stale? @doughs
    end

    def new
      @dough = Dough.new
      DoughAttribute.pizza_sizes.each do |key, value|
        @dough.dough_attributes << DoughAttribute.new(pizza_size: key)
      end
      render :new if stale? @dough
    end

    def edit
      @dough = Dough.find(params[:id])
      render :edit if stale? @dough
    end

    def create
      @dough = Dough.new(dough_params)
      if @dough.save
        redirect_to admin_doughs_path, success: 'Тесто успешно добавлено'
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

    private

    def main_menu_key
      @main_menu_key = :doughs
    end

    def dough_params
      params.require(:dough).permit(
        :name,
        { dough_attributes_attributes: [:id, :pizza_size, :price, :weight] }
      )
    end
  end
end
