
# Possible values
class ParameterValue < ApplicationRecord
  belongs_to :parameter

  validates :value, presence: true

  def weight
    default_weight || parameter.default_weight
  end

  def name
    value
  end
end
