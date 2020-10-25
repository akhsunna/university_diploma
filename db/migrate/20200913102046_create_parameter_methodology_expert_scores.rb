class CreateParameterMethodologyExpertScores < ActiveRecord::Migration[6.0]
  def change
    create_table :parameter_methodology_expert_scores do |t|
      t.belongs_to :parameter_value
      t.belongs_to :methodology
      t.belongs_to :expert_request

      t.integer :status, default: 0

      t.integer :score
      t.integer :expert_weight
    end
  end
end
