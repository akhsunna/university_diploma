module MethSelecting
  class ScoresByTopsis
    def call(project)
      # project.results_preparing!

      @methodologies = Methodology.all
      @p_values = project.confirmed_parameter_values

      matrix = generate_matrix


      # matrix = [
      #   [250, 16, 12, 5],
      #   [200, 16, 8, 3],
      #   [300, 32, 16, 4],
      #   [275, 32, 8, 4],
      #   [225, 16, 16, 2]
      # ]


      matrix = normalized_matrix(matrix)
      matrix = weighted_matrix(matrix)

      ideal_solutions = ideal_solutions(matrix)
      distances = calculate_distances(matrix, ideal_solutions)
      scores = get_scores(distances)
      assign_scores(project, scores)






      # project.finished!
    end

    attr_reader :methodologies, :p_values

    def m_count
      @m_count ||= methodologies.count
    end

    def p_count
      @p_count ||= p_values.count
    end

    def generate_matrix
      methodologies.map do |m|
        p_values.map do |ppv|
          m.get_score_of(ppv.parameter_value_id)
        end
      end
    end

    def normalized_matrix(array)
      col_sum = Array.new(p_count, 0)

      p_count.times do |i|
        col_sum[i] = Math.sqrt(
          array.inject(0) { |sum, a| sum + (a[i] ** 2) }
        )
      end

      array.map do |row|
        row.map.each_with_index do |e, i|
          e / col_sum[i]
        end
      end
    end

    def weighted_matrix(array)
      array.map do |row|
        row.map.each_with_index do |e, i|
          e * p_values[i].weight
        end
      end
    end

    def ideal_solutions(array)
      ideals = Array.new(p_count, 0)

      p_count.times do |i|
        column = array.map { |a| a[i] }
        ideals[i] = [ column.max, column.min ]
      end

      ideals
    end

    def calculate_distances(array, ideals)
      array.map do |row|

        d_max =
          row.each_with_index.inject(0) do |sum, (e, i)|
            sum + (e - ideals[i][0]) ** 2
          end
        d_max = Math.sqrt(d_max)


        d_min =
          row.each_with_index.inject(0) do |sum, (e, i)|
            sum + (e - ideals[i][1]) ** 2
          end
        d_min = Math.sqrt(d_min)


        [d_max, d_min]
      end
    end

    def get_scores(distances)
      distances.map do |d_max, d_min|
        d_min / (d_max + d_min)
      end
    end

    def assign_scores(project, scores)
      scores.each_with_index do |s, i|
        project.methodology_scores.find_or_initialize_by(methodology_id: methodologies[i].id).update(topsis_score: s)
      end
    end
  end
end
