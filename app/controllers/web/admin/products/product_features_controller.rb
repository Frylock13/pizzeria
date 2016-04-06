module Web
  module Admin
    module Products
      class ProductFeaturesController < Web::Admin::ApplicationController
        before_action :menu_key
        helper_method :feature_values, :features, :product, :product_features

        def index
          # render :index if stale? @product_features | layout_resources
        end

        def new
          @product_feature = ProductFeature.new
        end

        def edit
          @product_feature = ProductFeature.find(params[:id])
        end

        def create
          @product_feature = ProductFeature.new(product_feature_params)
          if @product_feature.save
            redirect_to [:edit, :admin, product, @product_feature], success: 'Атрибут успешно добавлен'
          else
            render :new, change: :new_product_feature, layout: !request.xhr?
          end
        end

        def update
          @product_feature = ProductFeature.find(params[:id])
          if @product_feature.update(product_feature_params)
            redirect_to [:edit, :admin, product, @product_feature], success: 'Атрибут успешно обновлен'
          else
            render :edit, change: "edit_product_feature_#{@product_feature.id}", layout: !request.xhr?
          end
        end

        def destroy
          @product_feature = ProductFeature.find(params[:id])
          if @product_feature.destroy
            flash[:success] = 'Атрибут успешно удален'
          else
            flash[:success] = 'Невозможно удалить атрибут'
          end
          redirect_to [:admin, product, :product_features], change: :product_features
        end

        private

        def menu_key
          @menu_key = :products
        end

        def feature_values
          @feature_values ||= FeatureValue.all.order(name: :asc)
        end

        def features
          @features ||= Feature.all.order(name: :asc)
        end

        def product
          @product ||= Product.find(params[:product_id])
        end

        def product_features
          @product_features ||= product.product_features
                                       .includes(:feature, :feature_value)
                                       .order('features.name', 'feature_values.name')
        end

        def product_feature_params
          params.require(:product_feature).permit(:feature_id, :feature_value_id, :price, :weight)
                                          .merge(product_id: params[:product_id])
        end
      end
    end
  end
end
