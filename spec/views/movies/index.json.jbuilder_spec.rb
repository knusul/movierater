require 'rails_helper'

RSpec.describe "movies/index.json.jbuilder", type: :view do
  let :movies do
    assign(:movies, [
      Movie.create!(
        :title => "Title",
        :description => "Description",
        :ratings => [Rating.create(score: 10)]
      ),
      Movie.create!(
        :title => "Title2",
        :description => "Description2",
        :ratings => [Rating.create(score: 10)]
      )
    ])
  end

  it "renders rating for each movie" do
    render :template => "movies/index", :locals => { :movies => movies }, :formats => :json, :handler => :jbuilder
    movies = JSON.parse(rendered)
    movies.each do |movie|
      expect(movie.keys).to include("rating")
    end
  end
end
