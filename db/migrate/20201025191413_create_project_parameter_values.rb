class CreateProjectParameterValues < ActiveRecord::Migration[6.0]
  def change
    create_table :project_parameter_values do |t|
      t.belongs_to :project
      t.belongs_to :parameter
      t.belongs_to :parameter_value
    end
  end
end
