class Order < ActiveRecord::Base

    has_many :order_products, dependent: :destroy
    has_many :products, through: :order_products

    accepts_nested_attributes_for :order_products, :reject_if => :all_blank, :allow_destroy => true
end
