class BakedGood < ActiveRecord::Base
  belongs_to :bakery

  scope :by_price, -> { order(price: :desc) }

end
