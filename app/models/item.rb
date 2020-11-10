class Item < ApplicationRecord
  attr_reader :discount

  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :discounts, through: :merchant
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def self.active_items
    where(active: true)
  end

  def self.by_popularity(limit = nil, order = "DESC")
    left_joins(:order_items)
    .select('items.id, items.name, COALESCE(sum(order_items.quantity), 0) AS total_sold')
    .group(:id)
    .order("total_sold #{order}")
    .limit(limit)
  end

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def eligible_discount(quantity)
    @discount = discounts.where('quantity <= ?', quantity).order(:rate).last
  end

  def adjusted_price
    price * (1 - (@discount.rate / 100))
  end
end
