class AddColumnStatusToExpertRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :expert_requests, :status, :integer, default: 0
  end
end
