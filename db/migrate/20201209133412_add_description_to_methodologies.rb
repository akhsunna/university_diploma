class AddDescriptionToMethodologies < ActiveRecord::Migration[6.0]
  def change
    add_column :methodologies, :description, :text
  end
end
