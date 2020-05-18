class BillingsController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def new_card
    respond_to do |format|
      format.js
    end
  end

  def create_card 
    respond_to do |format|
      if current_user.stripe_id.nil?
        customer = Stripe::Customer.create({"email": current_user.email}) 
        #here we are creating a stripe customer with the help of the Stripe library and pass as parameter email. 
        current_user.update(:stripe_id => customer.id)
        #we are updating current_user and giving to it stripe_id which is equal to id of customer on Stripe
      end

      card_token = params[:stripeToken]
      #it's the stripeToken that we added in the hidden input
      if card_token.nil?
        format.html { redirect_to billing_path, error: "Oops"}
      end
      #checking if a card was giving.

      customer = Stripe::Customer.new current_user.stripe_id
      customer.source = card_token
      #we're attaching the card to the stripe customer
      customer.save

      format.html { redirect_to success_path }
    end
  end

  def success
    @order = current_user.orders.last
    @order_items = @order.order_items
  end

  def payment
    customer = Stripe::Customer.new current_user.stripe_id
    @payment = Stripe::Charge.create customer: customer.id,
                                     amount: current_user.orders.last.subtotal*100,
                                     description: "Payments",
                                     currency: "usd"
    if @payment.save
      current_user.orders.last.status = "Paid"
    end
    flash[:success] = t ".success"
    redirect_to orders_path
  end

  def payment_from_order
    customer = Stripe::Customer.new current_user.stripe_id
    @payment = Stripe::Charge.create customer: customer.id,
                                     amount: current_user.orders.last.subtotal*100,
                                     description: "Payments",
                                     currency: "usd"
    if @payment.save
      current_user.orders.last.status = "Paid"
    end
    flash[:success] = t ".success"
    redirect_to orders_path
  end

  private

  def payment_params customer, order
    {
      customer: customer.id,
      amount: order.subtotal / Settings.exchange,
      description: t(".payments"),
      currency: :usd
    }
  end
end
