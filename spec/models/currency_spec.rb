require 'rails_helper'

RSpec.describe Currency, :type => :model do
  it 'can be dollars' do
    expect(build(:dollars)).to be_dollars
  end

  it 'can be colones' do
    expect(build(:colones)).to be_colones
  end
end
