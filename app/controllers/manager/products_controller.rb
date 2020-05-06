# frozen_string_literal: true

module Manager
  class ProductsController < Manager::BaseController
    before_action :load_product, only: %i[edit update destroy]
    def index
      @products = Product.page(params[:page]).order(created_at: :desc)
    end

    def show; end

    def new
      @product = Product.new
      @image = @product.images.build
    end

    def create
      @product = Product.new product_params.merge(admin_id: current_admin.id)
      if @product.save
        params[:product][:images].each do |image|
          @product.images.create file: image
        end
        flash[:success] = "Product was successfully created."
        redirect_to manager_products_path
      else
        @product.images.build
        render :new
      end
    end

    def edit; end

    def update
      if @product.update product_params
        if params.dig(:product, :images)
          params[:product][:images].each do |image|
            @product.images.create file: image
          end
        end
        flash[:success] = "Products updated"
        redirect_to edit_manager_product_path
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      flash[:success] = "Product Deleted"
      redirect_to manager_products_path
    end

    private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity,
                                      images_attributes: %i[file product_id id])
    end
  end
end
