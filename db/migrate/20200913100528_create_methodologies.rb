class CreateMethodologies < ActiveRecord::Migration[6.0]
  def change
    create_table :methodologies do |t|
      t.string :name
    end
  end
end
