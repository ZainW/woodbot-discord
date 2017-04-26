require 'discordrb'
require 'yaml'
require 'pry'

require_relative 'config.rb'

module WoodBot

  Dir['modules/*.rb'].each { |r| require_relative r; puts "Loaded: #{r}" }
  modules = [
    General,
    # Heroes,
    Builds
  ]
  CONFIG = Config.new('config/application.yml')
  token = CONFIG.DEVTOKEN if ENV["WOODBOT_ENV"] == "development"
  clientid = CONFIG.DEVCLIENTID if ENV["WOODBOT_ENV"] == "development"
  bot = Discordrb::Commands::CommandBot.new token: token, client_id: clientid, prefix: '-'

  modules.each { |m| bot.include! m; puts "Included: #{m}" }
  puts "This bot's invite URL is #{bot.invite_url}."
  bot.run
end
