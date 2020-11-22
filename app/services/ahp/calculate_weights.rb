module Ahp
  class CalculateWeights
    def call(project)
      @project = project

      matrix = generate_matrix
      n_matrix = normalized_matrix(matrix)

      weights = get_weights(n_matrix)
      weights_hash = pids.zip(weights).to_h

      save_weights(weights_hash)

      p 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
      p check_consistency(matrix, weights)

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
        col_sum[i] = array.sum { |a| a[i] }
      end

      array.map do |a|
        a.map.each_with_index do |e, i|
          e / col_sum[i].to_f
        end
      end
    end

    def get_weights(array)
      array.map do |a|
        a.sum.to_f / a.size
      end
    end

    def save_weights(weights_hash)
      project.parameter_values.each do |v|
        v.update_columns(weight: weights_hash[v.parameter_id])
      end
    end

    def check_consistency(array, weights)
      return true if count < 3

      lambda_max = calculate_lambda_max(array, weights)

      if count > 15
        lambda_max < 0.1 * (accepted_lambda_max - count)
      else
        consistency_index = calculate_consistency_index(lambda_max)
        (consistency_index / random_index) < 0.1
      end
    end

    def calculate_consistency_index(lambda_max)
      (lambda_max - count) / count.to_f
    end

    def calculate_lambda_max(array, weights)
      array.map do |a|
        a.map.each_with_index do |e, i|
          e * weights[i]
        end.sum
      end.map.each_with_index do |s, i|
        s.to_f / weights[i]
      end.sum.to_f / count
    end

    def random_index
      INDEXES[count]
    end

    def accepted_lambda_max
      L_MAX[count]
    end

    INDEXES = {
      3  => 0.52,
      4  => 0.89,
      5  => 1.11,
      6  => 1.25,
      7  => 1.35,
      8  => 1.40,
      9  => 1.45,
      10 => 1.49,
      11 => 1.51,
      12 => 1.54,
      13 => 1.56,
      14 => 1.57,
      15 => 1.58
    }.freeze

    L_MAX = {
      16 => 39.9676,
      17 => 42.7375,
      18 => 45.5074,
      19 => 48.2774,
      20 => 51.0473,
      21 => 53.8172,
      22 => 56.5872,
      23 => 59.3571,
      24 => 62.1270,
      25 => 64.8969,
    }.freeze
  end
end
