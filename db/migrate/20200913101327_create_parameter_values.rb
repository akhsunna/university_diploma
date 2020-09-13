class CreateParameterValues < ActiveRecord::Migration[6.0]
  def change
    create_table :parameter_values do |t|
      t.belongs_to :parameter
      t.string :value
    end
  end
end
