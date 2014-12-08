[User, BankAccount, Card].each &:destroy_all

user = User.create(first_name: "John", last_name: "Doe", birthdate: 30.years.ago)

colones = Currency.create currency: "colones", exchange_rate: 533, symbol: "¢"
dollars = Currency.create currency: "dollars", exchange_rate: 1, symbol: "$"

bank_account = user.bank_accounts.create(balance: 3000, currency_id: dollars.id, number: 123456)
bank_account.create_card(number: 1234, pin: 1234, card_type: "debit", expiration_date: 1.year.from_now)

puts "A user, a bank account and a credit card have been created. \nUse credit card number 1234 with pin 1234.\n\n"

another_user = User.create(first_name: "Mary", last_name: "Johnson", birthdate: 20.years.ago)

another_bank_account = another_user.bank_accounts.create(balance: 150000, currency_id: colones.id, number: 987654)
another_bank_account.create_card(number: 5678, pin: 5678, card_type: "credit", expiration_date: 1.year.from_now)

puts "A user, a bank account and a credit card have been created. \nUse credit card number 5678 with pin 5678.\n"