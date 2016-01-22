module Doctor
  class HealthCheck
    def perform
      result = {}

      result[:telnets] = analyze_telnet
      result[:databases] = analyze_database

      OpenStruct.new(result: result, has_error?: has_error?(result))
    end

    private
    def analyze_telnet
      process(TelnetAnalyser, Dto::TelnetResultDto)
    end

    def analyze_database
     process(DatabaseAnalyser, Dto::DatabaseResultDto)
    end

    def process(analyzer_class, dto_class)
      analyze_result = analyzer_class.new.analyse

      dto_result = []

      analyze_result.each do |result|
        dto_result << dto_class.new(result)
      end

      dto_result
    end

    def has_error?(result_hash)
      result_hash.values.each do |result_analyze|
        result_analyze.each do |result|
          if !result.status.eql?('ok')
            return true
          end
        end
      end

      false
    end
  end
end
