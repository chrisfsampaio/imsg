#!/usr/bin/env ruby
require "imsg/version"
require 'appscript'


class Chat

  attr_accessor :chat_number, :updated, :participants, :id

  def initialize(chat_number, updated, participants, id)
    self.chat_number = chat_number
    self.updated = updated
    self.participants = participants
    self.id = id
  end

  def to_s
    "#{chat_number} - #{participants.map(&:name).join(", ")}"
  end

  def self.fetch_latest
    ascript_chats.sort { |a, b| b.updated.get <=> a.updated.get } \
                 .map.with_index(1) { |chat, i| from_ascript_chat(chat, i) }
  end

  def self.ascript_chats
    Appscript.app("Messages").chats.get()
  end

  def self.from_ascript_chat(chat, chat_number)
    new(chat_number, chat.updated.get(), participants_from_ascript_chat(chat), chat.id_.get() )
  end

  def self.participants_from_ascript_chat(chat)
    chat.participants.get.map do |participant|
      Participant.from_ascript_participant(participant)
    end
  end
end

class Participant
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def self.from_ascript_participant(ascript_participant)
    self.new(ascript_participant.name.get())
  end
end

class ImsgHandler

  CHAT_DISPLAY_LIMIT = 12
  attr_accessor :chats, :messages

  # Check if a String is a integer number
  def is_i str
    !!(str =~ /^[-+]?[0-9]+$/)
  end

  def display_chats
    puts @chats.first(CHAT_DISPLAY_LIMIT).map(&:to_s).join("\n")
  end

  # Calls Applescript in order to trigger an iMessage message to a buddy
  # The buddy parameter accepts a String with either a chat number or a Buddy name
  def sendMessage message, buddy
    if is_i buddy
      puts "Sending \'#{message}\' to chat number #{buddy}"
      id = @chats.at( buddy.to_i - 1 ).id
      @messages.send_(message, to: @messages.chats.ID(id).get)
    else
      puts "Sending \'#{message}\' to buddy \'#{buddy}\'"
      `osascript -e 'tell application "Messages" to send \"#{message}\" to buddy \"#{buddy}\"'`
    end
  end

  # Shows the chat list along with their participants
  def showChatList
    @chats = Chat.fetch_latest
    @messages = Appscript.app("Messages")

    puts "\nWho would you like to send your message to?"
    puts "(You can choose a number or type a buddy name/email)\n\n"
    display_chats
  end

end

