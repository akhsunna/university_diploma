class CreateParameterMethodologyTotalScores < ActiveRecord::Migration[6.0]
  def change
    create_table :parameter_methodology_total_scores do |t|
      t.belongs_to :parameter_value
      t.belongs_to :methodology
      t.integer :score
    end
  end
end
