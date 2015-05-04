class User < ActiveRecord::Base
    validates :password, presence: true, length: { :in => 5..20 }
    validates :email, uniqueness: true
    def self.omniauth(auth)
        @user = User.new
        @user.provider = auth.provider
        @user.uid = auth.uid
        if auth.info
            @user.username = auth.info.name
            @user.email = auth.info.email
            @user.image = auth.info.image
            @user.password = auth.uid
        end
        return @user
    end
end
