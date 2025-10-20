require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  describe "POST #create" do
    context "with valid params" do
      context "when user is not signed in" do
        it "creates a new Comment" do
          expect {
            post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          }.to change(Comment, :count).by(1)
        end

        it "redirects to the movie" do
          post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          expect(response).to redirect_to(movie_path(movie))
        end
      end

      context "when user is signed in" do
        before { sign_in user }

        it "creates a new Comment" do
          expect {
            post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          }.to change(Comment, :count).by(1)
        end

        it "assigns the current user to the comment" do
          post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          expect(Comment.last.user).to eq(user)
        end

        it "assigns the current user's email to the author_name" do
          post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          expect(Comment.last.author_name).to eq(user.email)
        end

        it "redirects to the movie" do
          post :create, params: { movie_id: movie.to_param, comment: attributes_for(:comment) }
          expect(response).to redirect_to(movie_path(movie))
        end
      end
    end
  end
end
