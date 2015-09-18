require 'rails_helper'

RSpec.describe "movies/index", type: :view do
  before(:each) do
    assign(:movies, [
      Movie.create!(
        :title => "Title",
        :description => "Description"
      ),
      Movie.create!(
        :title => "Title",
        :description => "Description"
      )
    ])
  end

  it "renders a list of movies" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
