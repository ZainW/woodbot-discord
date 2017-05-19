module WoodBot
  require 'discordrb'
  require 'yaml'
  # require 'pry'
  Dir['modules/*.rb'].each { |r|
    require_relative r
    puts "Loaded: #{r}"
  }
  modules = [
    General,
    Heroes,
    Builds
  ]
  CONFIG = OpenStruct.new YAML.load_file 'config/application.yaml'
  token = CONFIG[ENV["WOODBOT_ENV"]]['TOKEN']
  clientid = CONFIG[ENV["WOODBOT_ENV"]]['CLIENTID']

  bot = Discordrb::Commands::CommandBot.new token: token, client_id: clientid, prefix: '-'
  modules.each { |m| bot.include! m; puts "Included: #{m}" }
  puts bot.invite_url
  bot.run
end
