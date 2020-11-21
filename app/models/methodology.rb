class Methodology < ApplicationRecord
  validates :name, presence: true

  has_many :expert_scores,
           class_name: 'ParameterMethodologyExpertScore',
           dependent: :destroy
  has_many :total_expert_scores,
           class_name: 'ParameterMethodologyTotalScore',
           dependent: :destroy

  def get_score_of(parameter_value_id)
    total_expert_scores.find_by(parameter_value_id: parameter_value_id)&.score
  end
end
