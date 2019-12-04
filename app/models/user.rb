class User < ApplicationRecord
  attr_accessor :current_password

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  # rubocop:disable Lint/AssignmentInCondition
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
  # rubocop:enable Lint/AssignmentInCondition

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
