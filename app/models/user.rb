class User < ApplicationRecord
    has_many :participants
    validates :email, uniqueness: true, presence: true
    validates :username, :password, presence: true
end
