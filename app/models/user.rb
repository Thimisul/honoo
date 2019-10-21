class User < ApplicationRecord
    has_many :participants
    validates :email, uniqueness: true
end
