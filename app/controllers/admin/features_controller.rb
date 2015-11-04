module Admin
  class FeaturesController < AdminController
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

    private

    def feature_params
      params.require(:feature).permit(:name)
    end
  end
end
