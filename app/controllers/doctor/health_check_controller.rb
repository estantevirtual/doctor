module Doctor
  class HealthCheckController < ApplicationController
    def index
      check_result = HealthCheck.new.perform

      status = check_result.has_error? ? :internal_server_error : :ok

      render json: check_result.result, status: status
    end
  end
end
