class CreateParameters < ActiveRecord::Migration[6.0]
  def change
    create_table :parameters do |t|
      t.string :name
      t.integer :default_weight

      t.timestamps
    end
  end
end
