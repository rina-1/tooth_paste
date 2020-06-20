class SocialProfile < ApplicationRecord
    # def self.find_or_create_from_auth(auth)
    #     provider = auth[:provider]
    #     uid = auth[:uid]
    
    #     self.find_or_create_by(provider: provider, uid: uid) do |user|
    #       user.name = name
    #     end
    # end
    # belongs_to :user
    # def self.from_omniauth(auth)
    #     user = User.where(email: auth.info.email).first
    #     sns_credential_record = SocialProfile.where(provider: auth.provider, uid: auth.uid)
    #     if user.present?
    #       unless sns_credential_record.present?
    #         SnsCredential.create(
    #           user_id: user.id,
    #           provider: auth.provider,
    #           uid: auth.uid
    #         )
    #       end
    #     elsif
    #       user = User.new(
    #         id: User.all.last.id + 1,
    #         email: auth.info.email,
    #         password: Devise.friendly_token[0, 20],
    #         name: auth.info.name
    #       )
    #       SocialProfile.new(
    #         provider: auth.provider,
    #         uid: auth.uid,
    #         user_id: user.id
    #       )
    #     end 
    #   user
    #   end



    
end
