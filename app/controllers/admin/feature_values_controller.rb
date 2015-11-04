module Admin
  class FeatureValuesController < AdminController
    def create
      @feature_value = FeatureValue.new(feature_value_params)
      if @feature_value.save
        respond_to do |format|
          format.html { redirect_to admin_products_path, success: 'Значение атрибута успешно добавлено' }
          format.json { render json: @feature_value }
        end
      else
        respond_to do |format|
          format.json { render json: { message: 'error' }, status: 422 }
        end
      end
    end

    private

    def feature_value_params
      params.require(:feature_value).permit(:name)
    end
  end
end
