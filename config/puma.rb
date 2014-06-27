min_threads = Integer(ENV['MIN_THREADS'] || 5)
max_threads = Integer(ENV['MAX_THREADS'] || 5)
 
threads min_threads, max_threads
workers Integer(ENV['WORKER_COUNT'] || 1 )

bind 'tcp://0.0.0.0:3001'

preload_app!
 
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    config = YAML.load(
      ERB.new(File.read(
        File.expand_path("../database.yml", __FILE__)
      )).result
    )

    ActiveRecord::Base.establish_connection(config[ENV['RACK_ENV']])
  end
end
