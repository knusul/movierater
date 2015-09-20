require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  let(:valid_attributes) {
    {title: "Oh ho", description: "Super oh ho movie"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MoviesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    user = double('user')
    allow(request.env['warden']).to receive(:authenticate!) { user }
    allow(controller).to receive(:current_user) { user }
  end

  describe "GET #index" do
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
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => new_attributes}, valid_session
        movie.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested movie as @movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        expect(assigns(:movie)).to eq(movie)
      end

      it "redirects to the movie" do
        movie = Movie.create! valid_attributes
        put :update, {:id => movie.to_param, :movie => valid_attributes}, valid_session
        expect(response).to redirect_to(movie)
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

    it "redirects to the movies list" do
      movie = Movie.create! valid_attributes
      delete :destroy, {:id => movie.to_param}, valid_session
      expect(response).to redirect_to(movies_url)
    end
  end

end
