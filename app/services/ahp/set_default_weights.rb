module Ahp
  class SetDefaultWeights
    def call(project)
      project.parameters_comparisons.destroy_all

      project.confirmed_parameter_values.each do |v|
        v.update_columns(weight: v.parameter_value.weight)
      end

      project.criteria_comparing_finished!
    end
  end
end
