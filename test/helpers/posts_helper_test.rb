require 'minitest_helper'

describe PostsHelper do
  it "converts number to currency" do
    number_to_currency(5).must_equal("$5.00")
  end
end
