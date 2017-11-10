class Variant < ApplicationRecord
  belongs_to :product
  has_many :variant_option_values, dependent: :destroy
  has_many :option_values, through: :variant_option_values
  has_many :product_order_items
  has_one  :image, as: :viewable, dependent: :destroy, class_name: 'ProductImage'
  accepts_nested_attributes_for :image, update_only: true

  with_options numericality: { greater_than_or_equal_to: 0, allow_nil: true } do
    validates :original_price
    validates :price, presence: true
  end
  validates :sku, uniqueness: true, allow_blank: true

  def find_option_value(option_type)
    option_values.find { |v| v.option_type_id.eql? option_type.id }
  end

  def build_option_values(values_sku)
    values_sku.each { |option_value| build_option_value(option_value) }
  end

  def build_option_value(option_value)
    variant_option_values.create(option_value:   option_value,
                                 option_type_id: option_value.option_type_id)
  end

  def sku_option_values_hash
    return {} if sku_option_values.blank?

    JSON.parse(sku_option_values)
  end
end
