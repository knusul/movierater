require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  def sign_in(user)
    allow(request.env['warden']).to receive(:authenticate!) { user }
    allow(controller).to receive(:current_user) { user }
  end

  let(:valid_attributes) {
    {title: "Oh ho", description: "Super oh ho movie"}
  }

  let(:user) do
    user = build :user
  end

  before(:each) do
    sign_in(user)
  end


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MoviesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    describe 'category filter' do
      it "filters by category" do
        movie = create :movie, :category => 'drama'
        movie2 = create :movie, :category => 'comedy'
        get :index, {category: 'drama'}, valid_session
        expect(assigns(:movies)).to eq([movie])
      end

      it "returns all movies without filter" do
        movie = create :movie, :category => 'drama'
        movie2 = create :movie, :category => 'comedy'
        get :index, valid_session
        expect(assigns(:movies)).to eq([movie, movie2])
      end

      it "returns all movies with empty filter" do
        movie = create :movie, :category => 'drama'
        movie2 = create :movie, :category => 'comedy'
        get :index, category: ''
        expect(assigns(:movies)).to eq([movie, movie2])
      end
    end

    it "assigns all movies as @movies" do
      movie = Movie.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:movies)).to eq([movie])
    end

    it "requires authentication" do
      allow(request.env['warden']).to receive(:authenticate!).
        and_throw(:warden, {:scope => :user})
      get :index, {}, valid_session
      expect(response).to redirect_to(new_user_session_path)
    end

  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Movie" do
        expect {
          post :create, {:movie => valid_attributes}, valid_session
        }.to change(Movie, :count).by(1)
      end

      it "assigns a newly created movie as @movie" do
        post :create, {:movie => valid_attributes}, valid_session
        expect(assigns(:movie)).to be_a(Movie)
        expect(assigns(:movie)).to be_persisted
      end

      it "redirects to the created movie" do
        post :create, {:movie => valid_attributes}, valid_session
        expect(response).to redirect_to(Movie.last)
      end
    end

  end

  describe "PUT #update" do
    context "with valid params" do
      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        expect(response).to redirect_to(movie)
      end

      it "updates rating for the movie" do
        movie = Movie.create! valid_attributes
        expect do
          put :update, {:id => movie.to_param, :movie => valid_attributes.merge({rating: 12})}, valid_session
        end.to change{Rating.count}.by(1)
      end

      it "changes existing rating for the movie" do
        movie = Movie.create! valid_attributes
        movie.ratings.create :user => user, :score => 3
        put :update, {:id => movie.to_param, :movie => valid_attributes.merge({rating: 5})}, valid_session
        expect(movie.ratings.average(:score)).to eq 5
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete :destroy, {:id => movie.to_param}, valid_session
      }.to change(Movie, :count).by(-1)
    end

    it "destroys the requested movie and ratings" do
      movie = Movie.create! valid_attributes
      movie.ratings.create :score => 2, :user => user
      expect {
        delete :destroy, {:id => movie.to_param}, valid_session
      }.to change(Movie, :count).by(-1)
    end

    it "redirects to the movies list" do
      movie = Movie.create! valid_attributes
      delete :destroy, {:id => movie.to_param}, valid_session
      expect(response).to redirect_to(movies_url)
    end
  end

end
