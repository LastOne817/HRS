class User < ActiveRecord::Base
    def self.omniauth(auth)
        create! do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            if auth.info
                user.username = auth.info.name
                user.email = auth.info.email
                user.image = auth.info.image
            end
        end
    end
end
