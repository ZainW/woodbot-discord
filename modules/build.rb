require 'net/http'
require 'json'
require 'uri'
module WoodBot
  module Builds
    extend Discordrb::Commands::CommandContainer
    command(:build, description: "returns stats / abilities from items ", usage: "build <item> <item> etc.", min_args: 2, max_args: 6) do |event, *items|
      uri = URI.parse('http://localhost:3000/builds/')
      params = Hash[items.each_with_index.map { |item, index| ["item#{index+1}", item].flatten }]
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      build = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
      embed_items = build['items'].join(",").gsub!(",", " ")
      build.delete('items')
      event.channel.send_embed do |embed|
        embed.color = 0x059f05
        embed.description = "Your build contains #{embed_items}"
        embed.author = {
          name: 'Build',
          icon_url: 'http://emojipedia-us.s3.amazonaws.com/cache/fc/69/fc6975fa7aa599c791172c00d0efc031.png'
        }
        build.each do |key, value|
          embed.add_field name: key.capitalize, value: value.to_s, inline: true
        end
      end

    end
  end
end
