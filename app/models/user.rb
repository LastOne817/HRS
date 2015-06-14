class User < ActiveRecord::Base
    validates :password, presence: true     # , length: { :in => 5..20 }
    validates :email, uniqueness: true
    serialize :checklist

    has_one :like

    def self.omniauth(auth)
        @user = User.new
        @user.provider = auth.provider
        @user.uid = auth.uid
        auth_info = auth.info
        if auth.info
            @user.username = auth_info.name
            @user.email = auth_info.email
            @user.image = auth_info.image
            @user.password = auth.uid
        end
        return @user
    end
end
