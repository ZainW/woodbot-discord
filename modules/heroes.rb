require 'net/http'
require 'json'
require 'uri'
module WoodBot
  module Heroes
    extend Discordrb::Commands::CommandContainer
    command(:hero, description: "Returns Hero", usage:"hero <hero>", min_args: 1, max_args: 1) do |event, hero|
      event.channel.start_typing
      uri = URI.parse("http://localhost/heroes/#{hero}")
      http = Net::HTTP.new(uri.host, 3000)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      if response.code == 200

      end
      hero = JSON.parse(response.body)

      event.channel.send_embed { |e|
        e.title = "Hero: #{hero['name']}"
        e.add_field(
          name: "Type: #{hero['hero_type'].capitalize}",
          value: "Attack Type: #{hero['attack_type']}    Attack Range: #{hero['attack_range']}"
          )
      }
    end
  end
end
