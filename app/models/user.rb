class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_favorites, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
    end
  end
# メガネくんから教えてもらったコード
  # devise :trackable, :omniauthable, omniauth_providers: %i(google)
  # protected
  # def self.find_for_google(auth)
  #   user = User.find_by(email: auth.info.email)

  #   unless user
  #     user = User.create(name:     auth.info.name,
  #                       provider: auth.provider,
  #                       uid:      auth.uid,
  #                       token:    auth.credentials.token,
  #                       password: Devise.friendly_token[0, 20],
  #                       meta:     auth.to_yaml)
  #   end
  #   user
  # end
end
