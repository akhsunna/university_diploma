module Ahp
  class CreateRecords
    def call(project)
      parameters = project.confirmed_parameters

      parameters.find_each do |param_a|
        parameters.find_each do |param_b|
          value, inversed =
            if param_a.id == param_b.id
              [1, false]
            else
              ParametersComparison.default_for(param_a.id, param_b.id)
            end
          ParametersComparison.create(
            parameter_a: param_a,
            parameter_b: param_b,
            project: project,
            value: value,
            inversed: inversed,
            status: param_a.id == param_b.id ? :confirmed : :not_set
          )
        end
      end
    end
  end
end
