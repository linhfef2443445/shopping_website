# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: %i[Pending Ordered Paid Closed Completed]
  belongs_to :user
  before_create :set_order_status
  before_save :update_subtotal

  has_many :order_items, dependent: :destroy

  validates :address, presence: true, length: { maximum: 150 }
  validates :phone_number, presence: true, length: { minimum: 10 }
  validates :full_name, presence: true, length: { maximum: 50 }

  def destroyable
    created_at + 2.hours < Time.current
  end

  def time_left
    ((created_at + 2.hours - Time.current) / 1.minutes).round
  end

  private

  def update_subtotal
    self[:subtotal] = order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.product.price) : 0 }.sum
  end

  def set_order_status
    self[:status] = :Ordered
  end

  def make_charge
  charge = Stripe::Charge.create({
    # Total Amount user will be charged (in cents)
    amount: (total * 100).to_i,
    # Currency of charge
    currency: 'USD',
    # the applicant users Stripe Customer ID
    # expect format of "cus_0xxXxXXX0XXxX0"
    customer: user.stripe_customer_id,
    # Description of charge
    description: description,
    # Final Destination of charge (host standalone account)
    # Expect format of acct_00X0XXXXXxxX0xX
    }
  )
  # if the charge is successful, we'll receive a response in the charge object
  # We can then query that object via charge.paid
  # if true we can update our attribute
  # byebug
  update_attributes(paid: true, stripe_charge: charge.id) if charge.paid?

  rescue => e
    errors.add(:stripe_charge_error, "Could not create the charge. Info from Stripe: #{e.message}")
  end
end
