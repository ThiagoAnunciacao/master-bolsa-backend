ENV['RACK_ENV'] ||= 'development'

require "dotenv"
require "grape"
require "grape-entity"
require "active_record"
require "action_mailer"
require "activerecord-import"
require "sidekiq"
require "nokogiri"

root = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(root) unless $LOAD_PATH.include?(root)
Dotenv.load

require "config/database"
require "config/mailer"

require "app/mailers/user_mailer"

require "app/workers/quotes_load_worker"

require "app/models/acoes"

require "app/controllers/acoes_controller"

require "app/presenters/acoes_presenter"

require "app/controllers/application_controller"
