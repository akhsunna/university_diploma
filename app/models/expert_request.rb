class ExpertRequest < ApplicationRecord
  has_secure_token

  belongs_to :methodology

  validates :expert_weight, :expert_name, :token, presence: true
end
