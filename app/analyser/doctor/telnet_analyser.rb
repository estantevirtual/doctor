require 'net/telnet'

module Doctor
  DEFAULT_PORT = 80
  DEFAULT_TIMEOUT = 1
  DEFAULT_WAIT_TIME = 1

  class TelnetAnalyser
    def analyse
      result = []

      Doctor::ConfigManager.url_to_telnet_list.each { |active_record|
        result << validate_telnet_connection(active_record)
      }

      result
    end

    private

    def validate_telnet_connection(url)
      result = build_result(url)

      response = nil

      begin
        response = execute_telnet(url)

        result[:status] = 'ok'
      rescue Exception => ex
        result[:error_message] = ex.message
        result[:status] = 'error'
      ensure
        response.close unless response.nil?
      end

      OpenStruct.new(result)
    end

    def build_result(url)
      {
        name: url[:name],
        host: url[:host],
        port: url[:port] || DEFAULT_PORT,
        timeout: url[:timeout] || DEFAULT_TIMEOUT,
        wait_time: url[:wait_time] || DEFAULT_WAIT_TIME
      }
    end

    def execute_telnet(url)
      Net::Telnet::new(
        'Host' => url[:host],
        'Port' => url[:port] || DEFAULT_PORT,
        'Timeout' => url[:timeout] || DEFAULT_TIMEOUT,
        'Waittime' => url[:wait_time] || DEFAULT_WAIT_TIME
      )
    end
  end
end
