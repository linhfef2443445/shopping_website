class BillingsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::CardError, with: :catch_exception
  def index; end

  def new
  end

  def create
    StripeChargesServices.new(charges_params, current_user).call
    redirect_to orders_path
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
      format.html { redirect_to success_path(order_id: params[:order_id]) }
    end
  end

  def success
    @order = current_order
  end

  def payment
    customer = Stripe::Customer.new current_user.stripe_id
    @payment = Stripe::Charge.create customer: customer.id,
                                     amount: current_order.subtotal*100,
                                     description: "Payments",
                                     currency: "usd"
    if @payment.save
      current_order.update_attributes(status: "Paid")
    end
    flash[:success] = "Successful payment"
    redirect_to orders_path
  end

  private

  def current_order
    if params[:order_id] == nil
      current_order = current_user.orders.last
    else
      current_order = Order.find(params[:order_id])
    end
  end
end
