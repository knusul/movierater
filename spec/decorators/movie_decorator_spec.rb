require 'rails_helper'

RSpec.describe MovieDecorator do
  describe "#average_rating" do
    it "returns nil when no ratings given" do
      movie = build :movie
      expect(movie.decorate.average_rating).to be_nil
    end

    it "returns average rating" do
      user = create :user
      movie = create :movie
      movie.ratings << Rating.create(:user => user, :score => 3)
      movie.ratings << Rating.create(:user => user, :score => 5)
      expect(movie.decorate.average_rating).to eq 4
    end
  end

  describe "#rating_by" do
    it "returns rating by user" do
      user = create :user
      user2 = create :user
      movie = create :movie
      movie.ratings << Rating.create(:user => user, :score => 3)
      movie.ratings << Rating.create(:user => user2, :score => 5)
      expect(movie.decorate.rating_by(user)).to eq 3
      expect(movie.decorate.rating_by(user2)).to eq 5
    end
  end
end
