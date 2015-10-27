module Admin
  module Products
    class ProductFeaturesController < AdminController
      before_action :main_menu_key
      helper_method :product

      def index
        @product_features = product.product_features
      end

      def new
      end

      def edit
      end

      def create
      end

      def update
      end

      private

      def product
        @product ||= Product.find(params[:product_id])
      end

      def main_menu_key
        @main_menu_key = :products
      end

      def product_feature_params
        params.require(:product_feature).permit(:product_id, :feature_id, :feature_value_id, :price, :weight)
      end
    end
  end
end
