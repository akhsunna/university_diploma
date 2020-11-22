class ProjectMethodologyScore < ApplicationRecord
  belongs_to :project
  belongs_to :methodology

  scope :ordered, -> { order(weighted_sum_score: :desc) }

  def score
    weighted_sum_score
  end
end
