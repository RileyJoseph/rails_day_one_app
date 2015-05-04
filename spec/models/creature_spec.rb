require 'rails_helper'

RSpec.describe Creature, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:creature)).to be_valid

  end
  it "is invalid without a name" do
    expect(FactoryGirl.build(:creature, name: nil)).to_not be_valid
  end
it "is invalid without a description" do
  expect(FactoryGirl.build(:creature, description: nil)).to_not be_valid
end

end