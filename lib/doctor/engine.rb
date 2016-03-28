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
          save_current_logs

          define_doctor_log_if_needed(env)

          call_without_doctor(env)
        ensure
          ensure_logs
        end

        def ensure_logs
          Rails.logger = @rails_log unless @rails_log.nil?

          ActiveRecord::Base.logger = @active_record_log unless @active_record_log.nil?

          ActionController::Base.logger = @action_controller_log unless @action_controller_log.nil?
        end

        def save_current_logs
          @rails_log = Rails.logger
          @active_record_log = ActiveRecord::Base.logger
          @action_controller_log = ActionController::Base.logger
        end

        def define_doctor_log_if_needed(env)
          return unless env['PATH_INFO'].include?('doctor/health_check')

          doctor_log = Logger.new("#{Rails.root}/log/doctor.log")

          Rails.logger = doctor_log
          ActiveRecord::Base.logger = doctor_log
          ActionController::Base.logger = doctor_log
        end

        alias_method_chain :call, :doctor
      end
    end
  end
end
