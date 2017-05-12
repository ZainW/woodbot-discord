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
      hero.delete('')
      hero.delete('turn_rate')
      hero.delete('created_at')
      hero.delete('updated_at')
      talents = hero.delete('talents')
      event.channel.send_embed do |embed|
        embed.color = 0x059f05
        embed.author = {
          name: hero['name'].tr('_', ' '),
          icon_url: hero['profile_url']
        }
        hero.delete('profile_url')
        hero.delete('name')
        hero.each do |key, value|
          embed.add_field name: key.capitalize.tr('_', ' '), value: value.to_s, inline:true
        end
        value = ""
        talents.each do |levels, talentarr|
          value += "#{levels.tr("_", " ")}: #{talentarr[0]} / #{talentarr[1]}\n"
        end
        embed.add_field name: "Talents: ", value: value, inline: false
      end
    end
  end
end
