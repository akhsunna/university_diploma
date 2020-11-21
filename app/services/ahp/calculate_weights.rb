module Ahp
  class CalculateWeights
    def call(project)

      pids = project.parameters_comparisons.pluck(:parameter_a_id).uniq
      count = pids.count

      p 'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP'
      p pids


      values_hash =
        project.parameters_comparisons.map do |pc|
          [
            [pc.parameter_a_id, pc.parameter_b_id],
            pc.inversed ? 1.0 / pc.value : pc.value
          ]
        end.to_h

      p 'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'
      p values_hash

      array = []

      pids.each_with_index do |id, i|
        array[i] =
          pids.map do |jd|
            values_hash[[id, jd]]
          end
      end

      col_sum = Array.new(count, 0)

      count.times do |i|
        col_sum[i] = array.sum { |a| p a; a[i] }
      end

      array.map! do |a|
        a.map.each_with_index do |e, i|
          e / col_sum[i].to_f
        end
      end

      weights = array.map do |a|
        a.sum.to_f / a.size
      end

      weights_hash = pids.zip(weights).to_h

      p '00000000000000000000000000000000000000000000000000000'
      p '00000000000000000000000000000000000000000000000000000'
      p '00000000000000000000000000000000000000000000000000000'
      p weights_hash


      project.parameter_values.each do |v|
        v.update_columns(weight: weights_hash[v.parameter_id])
      end


      project.criteria_comparing_finished!
    end
  end
end
