class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.all

    # Search by title, director, or synopsis
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @movies = @movies.where(
        "title ILIKE ? OR director ILIKE ? OR synopsis ILIKE ?", 
        search_term, search_term, search_term
      )
    end

    # Filter by category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @movies = @movies.joins(:categories).where(categories: { id: params[:category_id] })
    end

    @movies = @movies.order(release_year: :desc).page(params[:page]).per(6)
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  def fetch_ai_data
    movie_title = params[:title]
    
    if movie_title.blank?
      render json: { error: "Por favor, forneça o título do filme" }, status: :unprocessable_entity
      return
    end

    gemini_service = GeminiService.new
    movie_data = gemini_service.fetch_movie_data(movie_title)

    if movie_data[:error]
      render json: { error: movie_data[:error] }, status: :unprocessable_entity
    else
      render json: movie_data
    end
  rescue => e
    render json: { error: "Erro ao buscar dados: #{e.message}" }, status: :internal_server_error
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :rating, :poster, :poster_url, category_ids: [])
  end

  def authorize_user!
    redirect_to root_path, alert: 'Not authorized' unless @movie.user == current_user
  end
end
