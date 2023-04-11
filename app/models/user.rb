class User < ApplicationRecord
    has_secure_password

    # model vaidations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    
end
