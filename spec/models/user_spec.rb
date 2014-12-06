require 'rails_helper'

RSpec.describe User, type: :model do
  it{ should(have_many(:bank_accounts)) }
  it{ should(have_many(:cards)) }
end
