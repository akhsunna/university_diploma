class AddWeightToProjectParametersValues < ActiveRecord::Migration[6.0]
  def change
    add_column :project_parameter_values, :weight, :decimal
  end
end
