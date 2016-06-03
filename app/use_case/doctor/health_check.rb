module Doctor
  class HealthCheck
    def perform
      result = {}

      result[:release_path] = analyze_release_path
      result[:telnets] = analyze_telnet
      result[:databases] = analyze_database
      result[:hds] = analyse_hds

      error_messages = list_all_error_messages(result)

      OpenStruct.new(
        result: result,
        has_error?: has_error?(result),
        error_messages: error_messages
      )
    end

    private

    def analyze_release_path
      process(ReleasePathAnalyser, Dto::ReleasePathResultDto)
    end

    def analyze_telnet
      process(TelnetAnalyser, Dto::TelnetResultDto)
    end

    def analyze_database
      process(DatabaseAnalyser, Dto::DatabaseResultDto)
    end

    def analyse_hds
      process(HdAnalyser, Dto::HdResultDto)
    end

    def process(analyzer_class, dto_class)
      analyze_result = analyzer_class.new.analyse

      dto_result = []

      analyze_result.each do |result|
        dto_result << dto_class.new(result)
      end

      dto_result
    end

    def has_error?(result) # rubocop:disable Style/PredicateName
      result.values.each do |result_analyze|
        result_analyze.each do |result|
          return true unless result.status.eql?('ok')
        end
      end

      false
    end

    def list_all_error_messages(result)
      errors = []
      result.values.each do |result_analyze|
        result_analyze.each do |result|
          next if result.status.eql?('ok')

          errors << result.error_message
        end
      end

      errors
    end
  end
end
