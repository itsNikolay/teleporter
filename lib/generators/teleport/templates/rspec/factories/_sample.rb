#FactoryGirl.define do
#  factory :user do
#    first_name "John"
#    sequence(:title) { |n| "Title #{n}" }
#    date_of_birth   { 21.years.ago }
#    email { "#{first_name}.#{last_name}@example.com".downcase }
#  end
#
#  factory :admin, class: User do
#    first_name "Admin"
#  end
#
#  factory :post do
#    user
#    association :author, factory: :user, last_name: "Writely"
#
#    trait :with_comments do
#      after(:create) do |post|
#        create_list :comment, 2, todo_item: post
#      end
#    end
#  end
#
#end
