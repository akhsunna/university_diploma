class ChangeDefaultWeightForParameters < ActiveRecord::Migration[6.0]
  def change
    remove_column :parameters, :default_weight, :integer
    remove_column :parameter_values, :default_weight, :integer
    remove_column :parameter_methodology_expert_scores, :score, :integer
    remove_column :parameter_methodology_expert_scores, :expert_weight, :integer
    remove_column :expert_requests, :expert_weight, :integer

    add_column :parameters, :default_weight, :decimal
    add_column :parameter_values, :default_weight, :decimal
    add_column :parameter_methodology_expert_scores, :score, :decimal
    add_column :parameter_methodology_expert_scores, :expert_weight, :decimal
    add_column :expert_requests, :expert_weight, :decimal
  end
end
