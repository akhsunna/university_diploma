class ExpertRequest < ApplicationRecord
  has_secure_token

  enum status: {
    created: 0,
    in_progress: 1,
    finished: 2
  }

  belongs_to :methodology
  has_many :scores, class_name: 'ParameterMethodologyExpertScore'

  validates :expert_weight, :expert_name, :token, presence: true
  validates :expert_weight, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10
  }

  before_validation :regenerate_token, on: :create, if: -> { token.blank? }
  after_create :create_records_for_scores

  def next_not_set_parameter
    scores.not_set.first.parameter_value.parameter
  end

  def update_total!
    scores.each do |score|
      score.update_total!
    end
  end

  def progress_percentage
    (100 - (scores.not_set.count / scores.count.to_f) * 100.0).round(1)
  end

  def path
    "/expert_requests/#{token}"
  end

  private

  def create_records_for_scores
    Parameter.find_each do |parameter|
      parameter.possible_values.find_each do |value|
        self.scores.create(expert_weight: expert_weight, parameter_value: value, methodology: methodology)
      end
    end
  end
end
