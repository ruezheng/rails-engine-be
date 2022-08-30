class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_precense_of :name, :description, :unit_price
  validates_numericality_of :unit_price
end
