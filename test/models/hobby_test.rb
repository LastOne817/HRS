require 'test_helper'

class HobbyTest < ActiveSupport::TestCase
    test "#hobby_create" do
        h = Hobby.create({:name => "Sample Hobby", :content => "This is a rich, active hobby"})
    end
end
