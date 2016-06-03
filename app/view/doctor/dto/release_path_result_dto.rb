module Doctor
  module Dto
    class ReleasePathResultDto
      attr_reader :status
      attr_reader :error_message

      def initialize(data)
        @status = data[:status]
        @path = data[:path]
        @last = data[:last_release]
      end
    end
  end
end
