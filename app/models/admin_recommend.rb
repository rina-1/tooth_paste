class AdminRecommend < ApplicationRecord
    belongs_to :admin
    belongs_to :paste
end
