class User < ApplicationRecord
  REGULAR_EXP = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,70}$/.freeze
  validate :password_complexity

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
    end
  end

  def password_complexity
    return if password.blank? || password =~ REGULAR_EXP

    errors.add :password, I18n.t('models.user.password')
  end
end
