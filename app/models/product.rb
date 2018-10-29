class Product < ActiveRecord::Base

    has_many :order_products, dependent: :destroy
    has_many :orders, through: :order_products

    has_many :doc_files, dependent: :destroy
    # accepts_nested_attributes_for :doc_files, :reject_if => :all_blank, :allow_destroy => true

end
