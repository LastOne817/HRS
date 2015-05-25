require 'test_helper'

class IdfTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    test "#idf_create_all" do
        p = Property.new
        p.name = "sample"
        p.save
        k = Keyword.new
        k.name = "sample"
        k.property_id = p.id
        k.save
        Idf.createAll
        i = Idf.find_by(prop: "sample")
        assert i!=nil
        k.destroy
        p.destroy
    end

    test '#idf_update' do
        p = Property.new
        p.name = "sample"
        p.save
        k = Keyword.new
        k.name = "sample"
        k.property_id = p.id
        k.save
        Tf.create("sample",1)
        h = Hobby.find(1)
        t = h.tfs.find_by(prop: "sample")
        Tf.update("sample sample",t.id)
        tt = h.tfs.find_by(prop: "sample")
        Idf.createAll
        Idf.update
        
        i = Idf.find_by(prop: "sample")
        
        assert i.value == 0

        tt.destroy
        k.destroy
        p.destroy
    end


    test '#idf_update_zero_exception' do
        p = Property.new
        p.name = "sample"
        p.save
        k = Keyword.new
        k.name = "sample"
        k.property_id = p.id
        k.save
        Tf.create("sample",1)
        h = Hobby.find(1)
        t = h.tfs.find_by(prop: "sample")
        Tf.update("same sple",t.id)
        tt = h.tfs.find_by(prop: "sample")
        Idf.createAll
        Idf.update

        i = Idf.find_by(prop: "sample")

        assert i.value == 0

        tt.destroy
        k.destroy
        p.destroy
    end

end
