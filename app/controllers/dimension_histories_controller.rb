class DimensionHistoriesController < ApplicationController
    before_action :set_dimension_history, only: [:show, :index]

    def index
        @dimension_histories = DimensionHistory.all
    end

    def show
        
    end

    private

    def set_dimension_history
        # @dimension_history = DimensionHistory.find(params[:id])
    end
end
