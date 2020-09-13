class Project < ApplicationRecord
  enum status: {
    created: 0,
    criteria_comparing: 1,
    questionnaire: 2,
    results_preparing: 3,
    finished: 4
  }

  belongs_to :user
  has_many :parameters_comparisons, dependent: :destroy

  validates :name, presence: true

  def next_for_compare
    parameters_comparisons.not_set.first
  end
end
