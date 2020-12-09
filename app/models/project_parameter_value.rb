class ProjectParameterValue < ApplicationRecord
  enum status: {
    not_set: 0,
    skipped: 1,
    confirmed: 2
  }

  belongs_to :project
  belongs_to :parameter
  belongs_to :parameter_value, optional: true

  scope :ordered, -> { order(weight: :desc) }
end
