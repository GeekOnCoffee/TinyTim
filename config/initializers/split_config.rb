Split.configure do |config|
  config.db_failover = true # handle redis errors gracefully
  config.db_failover_on_db_error = proc{|error| Rails.logger.error(error.message) }
  config.allow_multiple_experiments = true
  # config.robot_regex = /my_custom_robot_regex/
  # config.ignore_ip_addresses << '81.19.48.130'
end
