module WoodBot
  module General
    extend Discordrb::Commands::CommandContainer
    command(:ping) do |event|
      event.respond("Pong o/ #{event.user.name}!")
    end
    command(:invite) do |event|
      event.respond("<#{event.bot.invite_url}>")
    end
  end
end
