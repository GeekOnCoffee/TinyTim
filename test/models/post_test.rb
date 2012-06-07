require 'minitest_helper'

describe Post do
  it "should be invalid without a title" do
    post = FactoryGirl.build(:post, title: nil)
    post.valid?.must_equal false
  end

  it "should be invalid without a body" do
    post = FactoryGirl.build(:post, body: nil)
    post.valid?.must_equal false
  end
end
