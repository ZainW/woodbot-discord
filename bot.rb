require 'discordrb'
require 'yaml'
require 'pry'

require_relative 'config.rb'

CONFIG = Config.new('config/application.yml')


bot = Discordrb::Commands::CommandBot.new token: CONFIG.TOKEN, client_id: CONFIG.CLIENTID, prefix: 'w'

bot.run
