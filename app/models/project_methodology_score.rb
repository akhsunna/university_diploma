class ProjectMethodologyScore < ApplicationRecord
  belongs_to :project
  belongs_to :methodology

  # scope :ordered, -> { order(topsis_score: :desc) }
  scope :ordered, -> { order('((topsis_score + weighted_sum_score) / 2) desc') }

  def score
    (weighted_sum_score + topsis_score) / 2.0
  end
end
