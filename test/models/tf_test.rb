require 'test_helper'

class TfTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "#tf_create" do
    Tf.create("sample",1)
    h = Hobby.find(1)
    t = h.tfs.find_by(prop: "sample")
    assert t!=nil
    t.destroy
  end

  test "#tf_update" do
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
    tt = Tf.find(t.id)
    assert (tt.value - Math.log(3)).abs <= 0.01
    tt.destroy
    k.destroy
    p.destroy
  end
end
