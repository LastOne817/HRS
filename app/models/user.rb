class User < ActiveRecord::Base
    validates :password, length: { minimun: 5, maximum: 20 }
    validates :email, uniqueness: true
    def self.omniauth(auth)
        create! do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            if auth.info
                user.username = auth.info.name
                user.email = auth.info.email
                user.image = auth.info.image
                user.password = auth.uid
            end
        end
    end
end
