class CreateParametersComparisons < ActiveRecord::Migration[6.0]
  def change
    create_table :parameters_comparisons do |t|
      t.belongs_to :parameter_a
      t.belongs_to :parameter_b
      t.belongs_to :project

      t.integer :value, default: 1
      t.boolean :inversed, default: false
      t.integer :status, default: 0
    end
  end
end
