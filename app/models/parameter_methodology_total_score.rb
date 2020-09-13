class ParameterMethodologyTotalScore < ApplicationRecord
  belongs_to :parameter_value
  belongs_to :methodology

  validates :score, presence: true
  validates :score, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }
end
