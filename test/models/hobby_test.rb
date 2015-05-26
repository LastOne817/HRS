require 'test_helper'

class HobbyTest < ActiveSupport::TestCase
    test "#hobby_create" do
        p_rich = Property.find_by(:name => "rich")
        p_rich.keywords.create(:name => "rich")
        p_active = Property.find_by(:name => "active")
        p_active.keywords.create(:name => "active")

        h = Hobby.create({:name => "Sample Hobby", :content => "This is a rich active hobby"})

        rich = h.tfs.find_by(prop: "rich")
        refute_in_delta rich.value, 0
        active = h.tfs.find_by(prop: "active")
        refute_in_delta active.value, 0
        inactive = h.tfs.find_by(prop: "inactive")
        assert_in_delta inactive.value, 0
    end
end
