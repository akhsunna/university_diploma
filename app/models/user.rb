class User < ApplicationRecord
  enum role: {
    admin: 0,
    user: 1
  }

  has_secure_password

  has_many :projects, dependent: :destroy

  validates :username, :role, presence: true
  validates :username, uniqueness: true
end
