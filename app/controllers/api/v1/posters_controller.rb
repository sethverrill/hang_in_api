class Api::V1::PostersController < ApplicationController
    def index 
        #We are doing three things here: 
        #1. Do we have any parameters coming in? 
        #2. Querying for data (all or some based off params)- if any data manipulation is needed, go to the model!
        #3. DOING IT(process next line)  
        posters = Poster.all
        #5. Determine, am I exposing (serializer) something? Or am I displaying (views) something?
        render json: PosterSerializer.format_posters(posters)
        #render json: Poster.all
    end
end