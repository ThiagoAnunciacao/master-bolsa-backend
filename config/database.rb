require "active_record"
require "erb"
require "yaml"

config = YAML.load(
  ERB.new(File.read(
    File.expand_path("../database.yml", __FILE__)
  )).result
)

ActiveRecord::Base.establish_connection(config[ENV['RACK_ENV']])
