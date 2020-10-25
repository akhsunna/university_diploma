class AddStatusToProjectParameterValues < ActiveRecord::Migration[6.0]
  def change
    add_column :project_parameter_values, :status, :integer, default: 0
  end
end
