module Doctor
  class HealthCheckController < ApplicationController
    def index
      render json: '{status: "ok2"}'
    end
  end
end
