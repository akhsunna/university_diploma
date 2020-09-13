class ParameterMethodologyExpertScore < ApplicationRecord
  belongs_to :parameter_value
  belongs_to :methodology
  belongs_to :expert_request

  validates :score, :expert_weight, presence: true
  validates :score, :expert_weight, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }
end
