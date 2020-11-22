class ParametersComparison < ApplicationRecord
  enum status: {
    not_set: 0,
    skipped: 1,
    confirmed: 2
  }

  belongs_to :parameter_a, class_name: 'Parameter'
  belongs_to :parameter_b, class_name: 'Parameter'
  belongs_to :project, optional: true

  validates :value, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 9
  }
  validates :project_id, uniqueness: { scope: [:parameter_a_id, :parameter_b_id] }

  scope :for, ->(ida, idb) {
    where(parameter_a_id: ida, parameter_b_id: idb)
  }

  def simplified_value
    if value == 1
      0
    elsif inversed
      value * -1
    else
      value
    end
  end

  def simplified_value=(val)
    val = val.to_i
    if val == 0
      self.value = 1
      self.inversed = false
    elsif val.negative?
      self.value = val * -1
      self.inversed = true
    else
      self.value = val
      self.inversed = false
    end
  end

  def set_value_for_inversed!
    inversed_record.update!(
      status: :confirmed,
      inversed: !inversed,
      value: value
    )
  end

  def inversed_record
    project.parameters_comparisons.find_by(
      parameter_a: parameter_b,
      parameter_b: parameter_a
    )
  end
end
