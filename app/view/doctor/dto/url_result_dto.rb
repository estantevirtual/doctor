module Doctor
  module Dto
    class DatabaseResultDto
      def initialize(data)
        @status = data[:status]
        @error_message = data[:error_message]
        @active_record = data[:active_record]
      end
    end
  end
end
