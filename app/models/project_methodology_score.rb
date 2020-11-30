class ProjectMethodologyScore < ApplicationRecord
  belongs_to :project
  belongs_to :methodology

  scope :ordered, -> { order(weighted_sum_score: :desc) }

  def score
    (weighted_sum_score + topsis_score) / 2.0
  end
end
