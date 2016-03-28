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
        end

        def ensure_logs
          unless @current_rails_log.nil?
            Rails.logger = @current_rails_log
          end

          unless @current_active_record_log.nil?
            ActiveRecord::Base.logger = @current_active_record_log
          end

          unless @current_action_controller_log.nil?
            ActionController::Base.logger = @current_action_controller_log
          end
        end

        def save_current_logs
          @current_rails_log = Rails.logger
          @current_active_record_log = ActiveRecord::Base.logger
          @current_action_controller_log = ActionController::Base.logger
        end

        def define_doctor_log_if_needed(env)
          doctor_log = Logger.new("#{Rails.root}/log/doctor.log")

          if env['PATH_INFO'].include?('doctor/health_check')
            Rails.logger = doctor_log
            ActiveRecord::Base.logger = doctor_log
            ActionController::Base.logger = doctor_log
          end
        end

        alias_method_chain :call, :doctor
      end
    end
  end
end
