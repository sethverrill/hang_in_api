class Api::V1::PostersController < ApplicationController
    def index 
        #*We are doing three things here: 
        #*1. Do we have any parameters coming in? 
        #*2. Querying for data (all or some based off params)- if any data manipulation is needed, go to the model!
        #*3. DOING IT(process next line)  
        if params[:sort]
            posters = Poster.sort_by_creation(params[:sort])
        else
            posters = Poster.all
        end
        #*5. Determine, am I exposing (serializer) something? Or am I displaying (views) something?
        render json: PosterSerializer.format_posters(posters)
        #*render json: Poster.all
    end

    def show
        poster = Poster.find(params[:id])
        render json: PosterSerializer.format_single_poster(poster)
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
        params.permit(:name, :description, :price, :year, :vintage, :img_url)    
    end    
end