class Admin < ApplicationRecord


    before_create :generate_token
    before_save {self.email = email.downcase}

    has_secure_password
    has_one :entity, dependent: :destroy

    validates :name, presence: true, length: {minimum:3, maximum:20}
    validates :email, presence: true, length: {minimum:3, maximum:128}
    validates :password, presence: true, length: {minimum:8}, presence: true


    private

    def generate_token
        self.access_token = SecureRandom.hex(16)
    end
    

    
end
