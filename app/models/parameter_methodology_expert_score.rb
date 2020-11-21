class ParameterMethodologyExpertScore < ApplicationRecord
  enum status: {
    not_set: 0,
    skipped: 1,
    confirmed: 2
  }

  belongs_to :parameter_value
  belongs_to :methodology
  belongs_to :expert_request
  has_one :parameter, through: :parameter_value

  scope :for_parameter, ->(parameter_id) { joins(:parameter_value).where(parameter_values: { parameter_id: parameter_id }) }

  validates :score, :expert_weight, presence: true, if: -> { confirmed? }
  validates :score, :expert_weight, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }, allow_blank: true

  def update_total!
    total_record = ParameterMethodologyTotalScore.find_or_initialize_by(methodology: methodology, parameter_value: parameter_value)
    total_record.update_score!
  end

  def weighted_score
    score * expert_weight / 10.0
  end
end
