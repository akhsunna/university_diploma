module MethSelecting
  class ScoresByWeightedSum
    def call(project)
      project.results_preparing!

      Methodology.find_each do |methodology|
        n = 0
        sum = 0

        project.confirmed_parameter_values.each do |ppv|
          score = methodology.get_score_of(ppv.parameter_value_id)
          next unless score

          n += 1
          sum += score * ppv.weight
        end

        project.methodology_scores.find_or_initialize_by(methodology: methodology).update(weighted_sum_score: sum / n.to_f)
      end

      project.finished!
    end
  end
end
