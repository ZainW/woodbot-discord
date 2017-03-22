module WoodBot
  module General
    extend Discordrb::Commands::CommandContainer
    command(:ping) do |event|
      event.respond("Pong o/ #{event.user.name}!")
    end
  end
end
