module Ahp
  class CalculateWeights
    def call(project)
      @project = project

      matrix = generate_matrix
      matrix = normalized_matrix(matrix)

      weights_hash = get_weights(matrix)
      save_weights(weights_hash)

      project.criteria_comparing_finished!
    end

    private

    attr_reader :project

    def pids
      @pids ||= project.parameters_comparisons.pluck(:parameter_a_id).uniq
    end

    def count
      @count ||= pids.count
    end

    def generate_matrix
      values_hash =
        project.parameters_comparisons.map do |pc|
          [
            [pc.parameter_a_id, pc.parameter_b_id],
            pc.inversed ? 1.0 / pc.value : pc.value
          ]
        end.to_h

      array = []

      pids.each_with_index do |id, i|
        array[i] =
          pids.map do |jd|
            values_hash[[id, jd]]
          end
      end

      array
    end

    def normalized_matrix(array)
      col_sum = Array.new(count, 0)

      count.times do |i|
        col_sum[i] = array.sum { |a| p a; a[i] }
      end

      array.map do |a|
        a.map.each_with_index do |e, i|
          e / col_sum[i].to_f
        end
      end
    end

    def get_weights(array)
      weights = array.map do |a|
        a.sum.to_f / a.size
      end

      pids.zip(weights).to_h
    end

    def save_weights(weights_hash)
      project.parameter_values.each do |v|
        v.update_columns(weight: weights_hash[v.parameter_id])
      end
    end
  end
end
