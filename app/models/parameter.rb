class Parameter < ApplicationRecord
  has_many :possible_values, class_name: 'ParameterValue'

  validates :name, :default_weight, presence: true
end
