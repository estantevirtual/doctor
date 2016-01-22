module Doctor
  class HealthCheck
    def perform
      result = {}

      result[:telnets] = analyze_telnet
      result[:databases] = analyze_database

      result
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
  end
end
