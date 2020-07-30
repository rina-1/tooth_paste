class Genre < ApplicationRecord
    has_many :pastes, dependent: :destroy
    validates :genre_name, uniqueness: true, presence: true
end
