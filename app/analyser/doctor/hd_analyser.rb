require 'sys/filesystem'

module Doctor
  class HdAnalyser
    def analyse
      result = []

      Doctor::ConfigManager.directory_list.each { |directory|
        result << validate_free_space(directory)
      }

      result
    end

    def validate_free_space(directory)
      result = {name: directory[:name], alarm_if_less_than: directory[:alarm_if_less_than], path: directory[:path]}

      begin
        used_space = get_used_space(directory[:path])

        if (used_space > directory[:alarm_if_less_than])
          result[:error_message] = "The used space configured [#{directory[:alarm_if_less_than]}] for the directory #{directory[:path]} is at [#{used_space}]"
          result[:status] = 'error'
        else
          result[:status] = 'ok'
        end
      rescue Exception => ex
        result[:error_message] = ex.message
        result[:status] = 'error'
      end

      OpenStruct.new(result)
    end

    def get_used_space(path)
      stat = Sys::Filesystem.stat(path)
      free_space = (stat.block_size * stat.blocks_available) / 1024 / 1024 / 1024
      total_space = (stat.block_size * stat.blocks) / 1024 / 1024 / 1024
      (total_space - free_space) * 100 / total_space
    end
  end
end
