module Admin
  class FeaturesController < AdminController
    before_action :main_menu_key
    helper_method :feature

    def index
      @features = Feature.all
      @feature_values = FeatureValue.all
      # render :index if stale? [@features, @feature_values] | layout_resources
    end

    def edit
      # render :edit if stale? [feature] | layout_resources
    end

    def create
      @feature = Feature.new(feature_params)
      if @feature.save
        respond_to do |format|
          format.html { redirect_to admin_products_path, success: 'Атрибут успешно добавлен' }
          format.json { render json: @feature }
        end
      else
        respond_to do |format|
          format.json { render json: { message: 'error' }, status: 422 }
        end
      end
    end

    def update
      if feature.update(feature_params)
        FeaturesMergingService.new(feature).merge
        redirect_to admin_features_path, success: 'Атрибут успешно обновлен'
      else
        render :edit, change: "edit_feature_#{@feature.id}", layout: !request.xhr?
      end
    end

    def destroy
      if feature.destroy
        flash[:success] = 'Атрибут успешно удален'
      else
        flash[:success] = 'Невозможно удалить атрибут'
      end
      redirect_to admin_features_path
    end

    private

    def main_menu_key
      @main_menu_key = :features
    end

    def feature
      @feature ||= Feature.find(params[:id])
    end

    def feature_params
      params.require(:feature).permit(:name)
    end
  end
end
