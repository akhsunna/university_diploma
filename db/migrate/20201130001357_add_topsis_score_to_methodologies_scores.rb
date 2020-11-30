class AddTopsisScoreToMethodologiesScores < ActiveRecord::Migration[6.0]
  def change
    add_column :project_methodology_scores, :topsis_score, :decimal
  end
end
