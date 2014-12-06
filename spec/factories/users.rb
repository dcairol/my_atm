FactoryGirl.define do
  factory :user do
    first_name Faker::Name::first_name
    last_name Faker::Name::last_name
    birthdate Faker::Date::birthday
  end

  factory :another_user, class: "User" do
    first_name Faker::Name::first_name
    last_name Faker::Name::last_name
    birthdate 25.years.ago
  end
end
