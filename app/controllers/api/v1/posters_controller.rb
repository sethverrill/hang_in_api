class Api::V1::PostersController < ApplicationController
    def index 
        if params[:sort]
            posters = Poster.sort_by_creation(params[:sort])
        elsif params[:name]
            posters = Poster.i_like(params[:name])
        else
            posters = Poster.all
        end

        render json: PosterSerializer.format_posters(posters)
    end

    def show
        poster = Poster.find(params[:id])
        render json: PosterSerializer.format_single_poster(poster)
    end

    def update
        render json: Poster.update(params[:id], poster_params)
    end

    def create
        poster = Poster.create!(poster_params)
        render json: PosterSerializer.format_single_poster(poster)
    end


    def destroy
        Poster.find(params[:id]).destroy
    end


    private
    def poster_params
        params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end