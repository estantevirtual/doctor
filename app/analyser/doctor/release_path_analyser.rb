module Doctor
  class ReleasePathAnalyser
    def analyse
      [check_path]
    end

    private

    def check_path
      path = File.basename(Rails.root)
      last = Dir.entries("#{Rails.root}/..").sort_by { |x| File.basename(x) }.reverse[0]
      status = last == path ? 'ok' : 'error'
      OpenStruct.new(
        status: status,
        last_release: last,
        path: path
      )
    end
  end
end
