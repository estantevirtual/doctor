module Doctor
  module Dto
    class DatabaseResultDto
      attr_reader :status

      def initialize(data)
        @status = data[:status]
        @error_message = data[:error_message] unless data[:error_message].nil?
        @active_record = data[:active_record]
      end
    end
  end
end
