class Product < ApplicationRecord
  include Publishable
  include Recommendable

  mount_uploader :icon, ProductUploader
  belongs_to :category
  belongs_to :freight
  has_one :master,
          -> { where is_master: true },
          class_name: 'Variant'
  accepts_nested_attributes_for :master, update_only: true

  has_many :variants,
           -> { where(is_master: false) }

  has_many :option_types

  has_many  :images, as: :viewable, dependent: :destroy, class_name: 'ProductImage'

  validates :title, presence: true
  validates :icon, presence: true, on: :create
  attr_accessor :root_category
  enum product_type: { entity: 'entity', virtual: 'virtual' }

  scope :recommended, -> { where(recommended: true) }
  scope :published, -> { where(published: true) }

  if ENV['CURRENT_PROJECT'] == 'dpcms'
    ransacker :by_root_category, formatter: proc { |v|
      Category.find(v).self_and_descendants.pluck(:id)
    } do |parent|
      parent.table[:category_id]
    end
  end

  after_save :update_count_to_category
  after_destroy do
    Category.decrement_counter(:products_count, category_id)
  end

  def update_count_to_category
    return unless category_id_changed?

    Category.increment_counter(:products_count, category_id)
    Category.decrement_counter(:products_count, category_id_was) unless category_id_was.nil?
  end

  def self.in_category(category)
    where(category_id: category.self_and_descendants.pluck(:id))
  end

  def preview_icon
    return '' if icon.url.nil?

    icon.url(:sm)
  end

  # 当增加或删除规格值时，先删除不完整的sku,再进行重建variants
  def rebuild_variants_for_value_change
    destroy_incomplete_sku
    rebuild_variants
  end

  # 当删除规格时，并且被删除的规格有规格值时，先删除所有variants,再进行重建variants
  def rebuild_variants_for_type_delete(type_has_values = false)
    variants.destroy_all if type_has_values
    rebuild_variants
  end

  def rebuild_variants
    values_skus.each do |values_sku|
      sku_option_values = option_values_hash(values_sku)
      next if sku_exists?(sku_option_values)

      variant = variants.create(price: master.price,
                                original_price: master.original_price,
                                stock: master.stock,
                                sku_option_values: sku_option_values)
      variant.build_option_values(values_sku)
    end
  end

  def destroy_incomplete_sku
    current_option_type_size = option_types.size
    variants.each do |variant|
      variant.destroy if variant.option_values.size != current_option_type_size
    end
  end

  def sku_exists?(sku_option_values)
    variants.each do |variant|
      return true if variant.sku_option_values == sku_option_values
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
    return [] if values.blank?

    return values[0].product if values.size == 1

    values[0].product(*values[1..-1])
  end

  def strict_option_values
    @strict_option_values ||= option_types.map do |type|
      # type.option_values.map { |v|  v.id }
      type.option_values.to_a
    end.reject(&:blank?)
  end

  def freight_fee(province = nil, number)
    product_freight(province, number: number,
                              weight: master.weight,
                              volume: master.volume)
  end
end
