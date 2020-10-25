class ParameterMethodologyTotalScore < ApplicationRecord
  belongs_to :parameter_value
  belongs_to :methodology

  validates :score, presence: true
  validates :score, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }

  def expert_scores
    ParameterMethodologyExpertScore.where(parameter_value: parameter_value, methodology: methodology).confirmed
  end

  def update_score!
    scores = expert_scores
    update!(score: scores.inject(0) { |sum, score| sum + score.weighted_score } / scores.count)
  end
end
