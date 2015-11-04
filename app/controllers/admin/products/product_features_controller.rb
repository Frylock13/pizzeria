module Admin
  module Products
    class ProductFeaturesController < AdminController
      before_action :main_menu_key
      helper_method :feature_values, :features, :product

      def index
        @product_features = product.product_features
        render :index if stale? @product_features
      end

      def new
        @product_feature = ProductFeature.new()
      end

      def edit
      end

      def create
        @product_feature = ProductFeature.new(product_feature_params)
        if @product_feature.save
          redirect_to [:admin, product, :product_features], success: 'Атрибут успешно добавлен'
        else
          render :new, change: :new_product_feature, layout: !request.xhr?
        end
      end

      def update
      end

      private

      def feature_values
        @feature_values ||= FeatureValue.all.order(name: :asc)
      end

      def features
        @features ||= Feature.all.order(name: :asc)
      end

      def product
        @product ||= Product.find(params[:product_id])
      end

      def main_menu_key
        @main_menu_key = :products
      end

      def product_feature_params
        params.require(:product_feature).permit(:feature_id, :feature_value_id, :price, :weight)
                                        .merge(product_id: params[:product_id])
      end
    end
  end
end
