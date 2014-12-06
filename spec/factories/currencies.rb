FactoryGirl.define do
  factory :dollars, class: "Currency" do
    currency "dollars"
    exchange_rate 1
    symbol "$"
  end

  factory :colones, class: "Currency" do
    currency "colones"
    exchange_rate 533
    symbol "¢"
  end
end
