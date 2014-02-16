require "thor"
require "imsg/chat"
require "imsg/participant"

module Imsg
  class CLI < Thor
    include Thor::Actions

    CHAT_DISPLAY_LIMIT = 12

    # Sends a message to a buddy
    desc "message", "Send a message to a buddy"
    option :buddy, :aliases => 'b', :type => :string
    def message msg
      options[:buddy].nil? ? buddy = get_user_input("To whom would you like to send this message to?") : buddy = options[:buddy]

      puts "Sending '#{msg}' to buddy #{buddy}"
      `osascript -e 'tell application "Messages" to send \"#{msg}\" to buddy \"#{buddy}\"'`
    end

    # Sends a message to an existing chat
    desc "chat", "Send a new message to an existing chat"
    option :chat_number, :aliases => 'n', :type => :numeric
    def chat msg
      options[:chat_number].nil? ? number = get_user_input("Which chat would you like to send this message to?") : number = options[:chat_number]

      puts "Sending '#{msg}' to chat number #{number}"
      `osascript -e 'tell application "Messages" to send \"#{msg}\" to item #{number} of text chats'`
    end

    # Shows current chats
    desc "chats", "Shows your current chats"
    option :limit, :type => :numeric, :aliases => 'l'
    def chats
      limit = options[:limit].nil? ? CHAT_DISPLAY_LIMIT : options[:limit]
      puts Chat.display_chats(limit)
    end

    no_commands do
      def get_user_input message
        chats
        ask(message)
      end
    end

  end
end
