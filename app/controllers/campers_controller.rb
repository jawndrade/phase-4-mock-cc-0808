class CampersController < ApplicationController
    # :index, :show, :create
    # /campers/:id Note: you will need to serialize the data for this response differently than for the GET /campers route!
    rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperactSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def camper_not_found
        render json: { error: "Camper not found" }, status: :not_found
    end

end
