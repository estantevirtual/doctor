module Doctor
  class ReleasePathAnalyser
    def analyse
      result = []
      result << check_path
      result
    end

    private

    def check_path
      path = /(\d+)$/.match(Rails.root.to_s)[0]
      last = Dir.entries("#{Rails.root}/..").sort_by { |x| File.basename(x) }.reverse[0]
      status = last == path ? 'ok' : 'error'
      result = {
        status: status,
        last_release: last,
        path: path
      }
      OpenStruct.new(result)
    end
  end
end
