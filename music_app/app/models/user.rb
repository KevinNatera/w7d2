# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email,:password_digest,:session_token, presence:true 
    validates :email, :session_token, uniqueness:true 

    attr_reader :password 
    before_validation :ensure_session_token 

    def self.find_by_credentials(email,password)
        user = User.find_by(email: email)

        if user && user.is_password?(password)
            user
        else   
            nil
        end

    end 

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save! 
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def self.generate_session_token
        token = SecureRandom::urlsafe_base64
        token
    end
end


