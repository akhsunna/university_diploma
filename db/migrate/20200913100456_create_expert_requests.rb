class CreateExpertRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :expert_requests do |t|
      t.string :token
      t.string :expert_name
      t.integer :expert_weight
      t.belongs_to :methodology

      t.timestamps
    end
  end
end
