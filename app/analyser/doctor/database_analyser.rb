module Doctor
  class DatabaseAnalyser
    def analyse
      result = []

      Doctor::ConfigManager.active_record_list.each { |active_record|
        result << validate_database_connection(active_record)
      }

      result
    end

    private
    def validate_database_connection(active_record)
      result = {active_record: active_record.model_name}

      begin
        active_record.first
        result[:status] = 'ok'
      rescue Exception => ex
        result[:error_message] = ex.message
        result[:status] = 'error'
      end

      OpenStruct.new(result)
    end
  end
end
