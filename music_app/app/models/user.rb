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


    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end


end
