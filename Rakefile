ENV['RACK_ENV'] ||= (ENV['RAILS_ENV'] || 'development')
require File.expand_path("../config/application", __FILE__)

require "active_record_migrations"

database_config_file = File.expand_path("../config/database.yml", __FILE__)
database_config = ERB.new(File.read(database_config_file)).result
database_config = YAML.load(database_config)

ActiveRecordMigrations.configure do |c|
  c.schema_format = :sql
  c.database_configuration = database_config
  c.environment = ENV['RACK_ENV']
  c.db_dir = 'db'
end

ActiveRecordMigrations.load_tasks
