module Ahp
  class CalculateWeights
    def call(project)
      project.parameters_comparisons
      # TODO: implement!

      project.criteria_comparing_finished!
    end
  end
end
