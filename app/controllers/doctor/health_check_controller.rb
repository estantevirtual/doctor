module Doctor
  class HealthCheckController < ActionController::Base
    def index
      check_result = HealthCheck.new.perform

      if check_result.has_error?
        errors = check_result.error_messages
        Rails.logger.error(errors)
        status = :internal_server_error
      else
        status = :ok
      end

      render json: check_result.result, status: status
    end
  end
end
