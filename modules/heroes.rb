require 'net/http'
require 'json'
require 'uri'
module WoodBot
  module Heroes
    extend Discordrb::Commands::CommandContainer
    command(:hero, description: "Returns Hero", usage:"hero <hero>", min_args: 1, max_args: 1) do |event, hero|
      uri = URI.parse("http://localhost/heroes/#{hero}")
      http = Net::HTTP.new(uri.host, 3000)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))

      hero = JSON.parse(response.body)
      hero.delete('id')
      hero.delete('profile_url')
      hero.delete('')
      talents = hero.delete('talents')
      event.channel.send_embed do |embed|
        embed.color = 0x059f05
        embed.author = {
          name: hero['name'].tr('_', ' '),
          icon_url: "https://hydra-media.cursecdn.com/dota2.gamepedia.com/8/8e/#{hero['name'].tr(" ", "_")}_icon.png"
        }
        hero.delete('name')
        hero.each do |key, value|
          embed.add_field name: key.capitalize.tr('_', ' '), value: value.to_s, inline:true
        end
        value = ""
        talents.each do |levels, talentarr|
          value += "#{levels.tr("_", " ")}: #{talentarr[0]} / #{talentarr[1]}\n"
        end
        embed.add_field name: "Talents: ", value: value, inline: false
        # binding.pry
      end
    end
  end
end
