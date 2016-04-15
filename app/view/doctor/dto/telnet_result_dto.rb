module Doctor
  module Dto
    class TelnetResultDto
      attr_reader :status
      attr_reader :error_message

      def initialize(data)
        @name = data[:name]
        @host = data[:host]
        @port = data[:port]
        @timeout = data[:timeout]
        @wait_time = data[:wait_time]

        @status = data[:status]
        @error_message = data[:error_message] unless data[:error_message].nil?
      end
    end
  end
end
