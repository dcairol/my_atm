FactoryGirl.define do
  factory :bank_account do
    user
    association :currency, factory: :dollars
    number 123456
    balance 1000
  end

  factory :bank_account_in_colones, class: "BankAccount" do
    user
    association :currency, factory: :colones
    number 654321
    balance 250000
  end

end
