module Doctor
  class ConfigManager
    @@active_record_list = []
    @@url_to_telnet_list = []
    @@directory_list = []

    def self.active_record_list
      @@active_record_list
    end

    def self.url_to_telnet_list
      @@url_to_telnet_list
    end

    def self.directory_list
      @@directory_list
    end
  end
end
