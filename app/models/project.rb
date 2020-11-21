class Project < ApplicationRecord
  enum status: {
    created: 0,
    questionnaire_in_progress: 2,
    questionnaire_finished: 3,
    criteria_comparing_in_progress: 4,
    criteria_comparing_finished: 5,
    results_preparing: 6,
    finished: 7
  }

  belongs_to :user
  has_many :parameters_comparisons, dependent: :destroy
  has_many :parameter_values, dependent: :destroy, class_name: 'ProjectParameterValue'
  has_many :parameters, through: :parameter_values

  validates :name, presence: true

  after_create :create_records_for_parameter_values

  def next_for_compare
    parameters_comparisons.not_set.first
  end

  def next_for_value
    parameter_values.not_set.first
  end

  def values_progress_percentage
    @values_progress_percentage ||= (100 - (parameter_values.not_set.count / parameter_values.count.to_f) * 100.0).round(1)
  end

  private

  def create_records_for_parameter_values
    Parameter.find_each do |parameter|
      parameter_values.create(parameter: parameter)
    end
  end
end
