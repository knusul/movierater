require 'rails_helper'

RSpec.describe Movie, type: :model do
  it "should allow empty title and description"do
    expect(build(:movie, title: "", description: "")).to be_valid
  end
end
