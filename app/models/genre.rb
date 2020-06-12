class Genre < ApplicationRecord
    has_many :pastes
    validates :genre_name, uniqueness: true, presence: true
end
