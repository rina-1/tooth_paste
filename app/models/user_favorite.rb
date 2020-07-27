class UserFavorite < ApplicationRecord
    belongs_to :user
    belongs_to :paste
    validates :comment, presence: true, length: { minimum: 2 }
    # validates :paste_id, uniqueness: true
end 
