class AddDefaultWeightToParameterValues < ActiveRecord::Migration[6.0]
  def change
    add_column :parameter_values, :default_weight, :integer
  end
end
