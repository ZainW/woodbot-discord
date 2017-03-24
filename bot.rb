require 'discordrb'
require 'yaml'
require 'pry'

require_relative 'config.rb'

module WoodBot
  Dir['modules/*.rb'].each { |r| require_relative r; puts "Loaded: #{r}" }
  modules = [
    General,
    Heroes
  ]
  CONFIG = Config.new('config/application.yml')
  bot = Discordrb::Commands::CommandBot.new token: CONFIG.TOKEN, client_id: CONFIG.CLIENTID, prefix: 'w'

  modules.each { |m| bot.include! m; puts "Included: #{m}" }

  bot.run
end
