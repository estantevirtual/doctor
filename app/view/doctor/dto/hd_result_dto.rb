module Doctor
  module Dto
    class HdResultDto
      attr_reader :status
      attr_reader :error_message

      def initialize(data)
        @name = data[:name]
        @path = data[:path]
        @alarm_if_less_than = data[:alarm_if_less_than]

        @status = data[:status]
        @error_message = data[:error_message] unless data[:error_message].nil?
      end
    end
  end
end
