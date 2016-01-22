module Doctor
  class HealthCheckController < ApplicationController
    def index
      result = HealthCheck.new.perform
      render json: result, head: :ok
    end
  end
end
