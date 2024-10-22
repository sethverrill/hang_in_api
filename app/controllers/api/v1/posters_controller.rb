class Api::V1::PostersController < ApplicationController
    def index
        posters = Poster.all
        render json: PosterSerializer.format_posters(posters)
        #render json: Poster.all
    end
end