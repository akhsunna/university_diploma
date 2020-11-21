module Ahp
  class CreateRecords
    def call(project)
      parameter_ids = project.confirmed_parameters.pluck(:id)

      parameter_ids.each do |param_a|
        parameter_ids.each do |param_b|
          ParametersComparison.create(
            parameter_a_id: param_a,
            parameter_b_id: param_b,
            project: project,
            value: 1,
            inversed: param_a > param_b,
            status: param_a == param_b ? :confirmed : :not_set
          )
        end
      end
    end
  end
end
