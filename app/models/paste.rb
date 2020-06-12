class Paste < ApplicationRecord
    belongs_to :genre
    has_many :admin_recommeds
    attachment :image
end
