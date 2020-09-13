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

  scope :default, -> { where(project_id: nil) }
  scope :for, ->(ida, idb) {
    where(parameter_a_id: ida, parameter_b_id: idb)
  }

  def self.default_for(ida, idb)
    if (same = default.for(ida, idb).first)
      [same.value, false]
    elsif (inversed = default.for(idb, ida).first)
      [inversed.value, true]
    else
      [1, true]
    end
  end

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
end
