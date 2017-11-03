class Product < ApplicationRecord
  mount_uploader :icon, ProductUploader

  belongs_to :category
  has_one :master,
          -> { where is_master: true },
          class_name: 'Variant'
  accepts_nested_attributes_for :master, update_only: true

  has_many :variants,
           -> { where(is_master: false) }

  has_many :option_types

  validates :title, presence: true
  validates :icon, presence: true, on: :create
  attr_accessor :root_category

  def self.in_category(category)
    where(category_id: category.self_and_descendants.pluck(:id))
  end

  def preview_icon
    return '' if icon.url.nil?

    icon.url(:sm)
  end


  def master_price
      master.price
  end

  def rebuild_variants
    values_skus.each do |values_sku|
      sku_option_values = option_values_hash(values_sku)
      next if sku_exists?(sku_option_values)

      variant = variants.create(price: master_price,
                                sku_option_values: sku_option_values.to_json)
      variant.build_option_values(values_sku)
    end
  end

  def sku_exists?(sku_option_values)
    variants.each do |variant|
      if variant.sku_option_values_hash == sku_option_values
        return true
      end
    end

    false
  end

  def option_values_hash(values_sku)
    values_sku.each_with_object({}) do |o_value, hash|
      hash[o_value.option_type.id.to_s] = o_value.id
    end
  end

  # sku集合的生成可由 卡笛尔积的算法来生成
  def values_skus
    values = strict_option_values
    return  values[0].product if values.size == 1

    values[0].product(*values[1..-1])
  end

  def strict_option_values
    @strict_option_values ||= option_types.map do |type|
      # type.option_values.map { |v|  v.id }
      type.option_values.to_a
    end.reject(&:blank?)
  end

end
