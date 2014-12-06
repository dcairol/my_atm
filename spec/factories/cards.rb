FactoryGirl.define do
  factory :valid_card, class: "Card" do
    card_type "credit"
    expiration_date (Date.today + 2.weeks)
    number 1234
    pin 1234
  end

  factory :expired_card, class: "Card" do
    card_type "credit"
    expiration_date 1.week.ago
    number 4321
    pin 1234
  end

end
