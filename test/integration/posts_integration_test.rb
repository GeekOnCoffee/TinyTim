require 'minitest_helper'

describe "Posts integration" do
  it "should show a title on the new page" do
    visit(new_post_path)
    page.text.must_include "Title"
  end
end
