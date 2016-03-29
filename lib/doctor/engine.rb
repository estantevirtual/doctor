require 'rails/all'

module Doctor
  class Engine < ::Rails::Engine
    isolate_namespace Doctor

    # config that will allow the user to turn of the log feature
    config.use_same_log_file = false

    initializer('doctor', after:  'sprockets.environment') do |app|
      next if app.config.use_same_log_file

      Rails::Rack::Logger.class_eval do
        def call_with_doctor(env)
          logs = nil
          begin
            logs = backup_current_logs

            define_doctor_log_if_needed(env)

            call_without_doctor(env)
          ensure
            return_logs(logs) unless logs.nil?
          end
        end

        alias_method_chain :call, :doctor

        private

        def return_logs(logs)
          Rails.logger = logs.rails unless logs.rails.nil?

          ActiveRecord::Base.logger = logs.active_record unless logs.active_record.nil?

          ActionController::Base.logger = logs.action_controller unless logs.action_controller.nil?
        end

        def backup_current_logs
          OpenStruct.new(
            rails: Rails.logger,
            active_record: ActiveRecord::Base.logger,
            action_controller: ActionController::Base.logger
          )
        end

        def define_doctor_log_if_needed(env)
          return unless env['PATH_INFO'].include?('doctor/health_check')

          doctor_log = Logger.new("#{Rails.root}/log/doctor.log")

          Rails.logger = doctor_log
          ActiveRecord::Base.logger = doctor_log
          ActionController::Base.logger = doctor_log
        end
      end
    end
  end
end
