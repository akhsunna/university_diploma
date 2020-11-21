class CreateProjectMethodologyScores < ActiveRecord::Migration[6.0]
  def change
    create_table :project_methodology_scores do |t|
      t.belongs_to :project
      t.belongs_to :methodology
      t.decimal :weighted_sum_score
    end
  end
end
