FactoryGirl.define do
  factory :customer do
    sequence(:name) {|n| "achievemore customer#{n}"}
    sequence(:subdomain) {|n| "customer#{n}"}
  end
end
