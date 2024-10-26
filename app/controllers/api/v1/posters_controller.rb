class Api::V1::PostersController < ApplicationController
    def index 
        if params[:sort]
            posters = Poster.sort_by_creation(params[:sort])
        elsif params[:name]
            posters = Poster.i_like(params[:name])
        elsif params[:min_price]
            posters = Poster.min_price(params[:min_price])
        elsif params[:max_price]
            posters =Poster.max_price(params[:max_price])
        else
            posters = Poster.all
        end

        render json: PosterSerializer.format_posters(posters)
    end

    def show
        poster = Poster.find(params[:id])
        render json: PosterSerializer.format_single_poster(poster)
    rescue ActiveRecord::RecordNotFound => exception
        render json: {
            errors: [
                {
                    status: "404",
                    message: "Record not found"
                }
            ]
        }, status: :not_found
    end

    def update
        render json: Poster.update(params[:id], poster_params)
    end

    def create
        poster = Poster.create!(poster_params)
        render json: PosterSerializer.format_single_poster(poster)

    rescue ActiveRecord::RecordInvalid => exception
        render json: {
          errors: [
            {
              status: "422",
              message: "Cannot duplicate poster/all attributes must be filled out"
            }
          ]
        }, status: :unprocessable_entity
    end

    def destroy
        Poster.find(params[:id]).destroy
    end

    private
    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end