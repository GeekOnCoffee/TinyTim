# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "My Title"
    body "The cool body"
  end

  # NOTE (2012-06-07) jonk => other factories below

  # example of a future additional factory
  #factory :comment do
  #  column "value"
  #end
end
