
# Possible values
class ParameterValue < ApplicationRecord
  belongs_to :parameter

  has_many :expert_scores,
           class_name: 'ParameterMethodologyExpertScore',
           dependent: :destroy
  has_many :total_expert_scores,
           class_name: 'ParameterMethodologyTotalScore',
           dependent: :destroy

  validates :value, presence: true

  def weight
    default_weight || parameter.default_weight
  end

  def name
    value
  end

  def short_value
    value.truncate(35, omission: '...')
  end
end
