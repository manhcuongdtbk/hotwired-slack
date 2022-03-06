class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :channels_users, dependent: :destroy
  has_many :channels, through: :channels_users
  has_many :messages, dependent: :destroy

  enum :locale, Settings.i18n.available_locales.to_h, default: I18n.default_locale
end
