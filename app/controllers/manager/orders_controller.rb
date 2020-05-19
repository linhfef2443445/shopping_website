# frozen_string_literal: true

module Manager
  class OrdersController < Manager::BaseController
    before_action :load_order, only: %i[show edit update destroy]
    load_and_authorize_resource

    def index
      @orders = Order.page(params[:page]).order(created_at: :desc)
    end

    def show; end

    def edit; end

    def update
      if @order.update status: params[:order][:status]
        flash[:success] = "Order Status Updated"
        redirect_to manager_orders_path
      else
        render :edit
      end
    end

    def destroy
      @order.destroy
      redirect_to manager_orders_path, success: "Order Deleted"
    end

    private

    def load_order
      @order = Order.find(params[:id])
    end
  end
end
