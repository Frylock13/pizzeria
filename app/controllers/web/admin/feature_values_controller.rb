class Web::Admin::FeatureValuesController < Web::Admin::ApplicationController
  helper_method :feature_value, :features, :feature_values

  def edit
    @menu_key = :features
  end

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

  def update
    if feature_value.update(feature_value_params)
      FeatureValuesMergingService.new(feature_value).merge
      redirect_to admin_features_path, success: 'Значение атрибута успешно обновлено'
    else
      render :edit, change: "edit_feature_value_#{@feature_value.id}", layout: !request.xhr?
    end
  end

  def destroy
    if feature_value.destroy
      flash[:success] = 'Значение атрибута успешно удалено'
    else
      flash[:success] = 'Невозможно удалить значение атрибута'
    end
    redirect_to admin_features_path
  end

  private

  def feature_value
    @feature_value ||= FeatureValue.find(params[:id])
  end

  def features
    @features ||= Feature.all
  end

  def feature_values
    @feature_values ||= FeatureValue.all
  end

  def feature_value_params
    params.require(:feature_value).permit(:name)
  end
end
