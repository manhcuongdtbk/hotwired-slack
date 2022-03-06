class Channel < ApplicationRecord
  has_many :channels_users, dependent: :destroy
  has_many :users, through: :channels_users
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
