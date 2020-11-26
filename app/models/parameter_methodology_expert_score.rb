class ParameterMethodologyExpertScore < ApplicationRecord
  enum status: {
    not_set: 0,
    skipped: 1,
    confirmed: 2
  }

  belongs_to :parameter_value
  belongs_to :methodology
  belongs_to :expert_request, optional: true
  has_one :parameter, through: :parameter_value

  validates :score, :expert_weight, presence: true, if: -> { confirmed? }
  validates :score, :expert_weight, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }, allow_blank: true

  after_save :update_total, if: ->{ confirmed? }

  scope :for_parameter, ->(parameter_id) { joins(:parameter_value).where(parameter_values: { parameter_id: parameter_id }) }

  def update_total!
    total_record = ParameterMethodologyTotalScore.find_or_create_by(methodology: methodology, parameter_value: parameter_value, score: 0)
    total_record.update_score!
  end

  def weighted_score
    score * (expert_weight || 1) / 10.0
  end

  private

  def update_total
    update_total!
  end
end
