class ParameterValue < ApplicationRecord
  belongs_to :parameter

  validates :value, presence: true
end
