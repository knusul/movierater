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

  it "renders anchor div for backbone application" do
    render
    assert_select "#movies", :count => 1
  end
end
