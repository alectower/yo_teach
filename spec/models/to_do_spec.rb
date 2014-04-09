require 'spec_helper'

describe ToDo do
  let(:user) { FactoryGirl.create :user }

  it "has a valid factory" do
    FactoryGirl.build(:to_do, user: user).should be_valid
  end

  it "is invalid without a body" do
    FactoryGirl.build(:to_do, body: nil).should_not be_valid
  end
end
