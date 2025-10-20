require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:movie) { create(:movie, user: user) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: movie.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    context "when user is signed in" do
      before { sign_in user }

      it "returns a success response" do
        get :new
        expect(response).to be_successful
      end
    end

    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "when user is signed in" do
      before { sign_in user }

      context "with valid params" do
        it "creates a new Movie" do
          expect {
            post :create, params: { movie: attributes_for(:movie) }
          }.to change(Movie, :count).by(1)
        end

        it "redirects to the created movie" do
          post :create, params: { movie: attributes_for(:movie) }
          expect(response).to redirect_to(Movie.last)
        end
      end
    end

    context "when user is not signed in" do
      it "does not create a new Movie" do
        expect {
          post :create, params: { movie: attributes_for(:movie) }
        }.to_not change(Movie, :count)
      end

      it "redirects to the sign in page" do
        post :create, params: { movie: attributes_for(:movie) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    context "when user is signed in" do
      before { sign_in user }

      it "returns a success response" do
        get :edit, params: { id: movie.to_param }
        expect(response).to be_successful
      end

      context "when trying to edit another user's movie" do
        before { sign_in other_user }

        it "redirects to the root path" do
          get :edit, params: { id: movie.to_param }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to the sign in page" do
        get :edit, params: { id: movie.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT #update" do
    context "when user is signed in" do
      before { sign_in user }

      context "with valid params" do
        let(:new_attributes) { { title: "New Title" } }

        it "updates the requested movie" do
          put :update, params: { id: movie.to_param, movie: new_attributes }
          movie.reload
          expect(movie.title).to eq("New Title")
        end

        it "redirects to the movie" do
          put :update, params: { id: movie.to_param, movie: new_attributes }
          expect(response).to redirect_to(movie)
        end
      end

      context "when trying to update another user's movie" do
        before { sign_in other_user }

        it "does not update the movie" do
          put :update, params: { id: movie.to_param, movie: { title: "New Title" } }
          movie.reload
          expect(movie.title).to_not eq("New Title")
        end

        it "redirects to the root path" do
          put :update, params: { id: movie.to_param, movie: { title: "New Title" } }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "when user is not signed in" do
      it "does not update the movie" do
        put :update, params: { id: movie.to_param, movie: { title: "New Title" } }
        movie.reload
        expect(movie.title).to_not eq("New Title")
      end

      it "redirects to the sign in page" do
        put :update, params: { id: movie.to_param, movie: { title: "New Title" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is signed in" do
      before { sign_in user }

      it "destroys the requested movie" do
        movie_to_destroy = create(:movie, user: user)
        expect {
          delete :destroy, params: { id: movie_to_destroy.to_param }
        }.to change(Movie, :count).by(-1)
      end

      it "redirects to the movies list" do
        delete :destroy, params: { id: movie.to_param }
        expect(response).to redirect_to(movies_url)
      end

      context "when trying to destroy another user's movie" do
        before { sign_in other_user }

        it "does not destroy the movie" do
          movie_to_not_destroy = movie
          expect {
            delete :destroy, params: { id: movie_to_not_destroy.to_param }
          }.to_not change(Movie, :count)
        end

        it "redirects to the root path" do
          delete :destroy, params: { id: movie.to_param }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "when user is not signed in" do
      it "does not destroy the movie" do
        movie_to_not_destroy = movie
        expect {
          delete :destroy, params: { id: movie_to_not_destroy.to_param }
        }.to_not change(Movie, :count)
      end

      it "redirects to the sign in page" do
        delete :destroy, params: { id: movie.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
