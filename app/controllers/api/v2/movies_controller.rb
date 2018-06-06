module Api
  module V2
    class MoviesController < Api::V2::ApplicationController
      before_action :authenticate_request!, only: %i[rate unvote]

      def index
        render json: Movie.includes(:comments, :movie_ratings).all.order(:created_at)
      end

      def show
        render json: Movie.find(params[:id])
      end

      def rate
        rate = @current_user.movie_ratings.create(movie_id: params[:id], rating: params[:rating])
        if rate.save
          render json: Movie.find(params[:id])
        else
          render json: { error: "You already have voted" }, status: :unprocessable_entity
        end
      end

      def unvote
        @current_user.movie_ratings.find_by(movie_id: params[:id]).delete
        render json: Movie.find(params[:id]), status: :accepted
      end
    end
  end
end
