class Parameter < ApplicationRecord
  has_many :possible_values, class_name: 'ParameterValue'

  validates :name, :default_weight, presence: true

  validates :default_weight, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }
end
