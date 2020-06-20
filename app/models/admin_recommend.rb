class AdminRecommend < ApplicationRecord
    belongs_to :admin
    belongs_to :paste
    validates :comment, presence: true
    validates :paste_id, uniqueness: true
end
