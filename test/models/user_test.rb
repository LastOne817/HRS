require 'test_helper'

class UserTest < ActiveSupport::TestCase
    def test_user_from_omniauth
        num_of_users = User.count
        auth = OmniAuth.config.mock_auth[:facebook]
        user = User.omniauth(auth)
        user.save
        assert_equal num_of_users+1, User.count
    end
  # test "the truth" do
  #   assert true
  # end
end
