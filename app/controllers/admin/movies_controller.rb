module Admin
  class MoviesController < BaseController
    def index
    	@movies = Movie.all
    end

    def show
    end

    def new
      @movie = Movie.new
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        redirect_to action: :index
      else
        flash[:error] = "Something wrong with your input"
        redirect_to action: :new
      end
    end

    def edit
    end

    def update
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie successfully deleted"
      redirect_to action: :index
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :description, :year)
    end
  end
end
