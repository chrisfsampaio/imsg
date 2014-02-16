require "appscript"

module Imsg
  class Chat

    attr_accessor :chat_number, :updated, :participants

    def initialize(chat_number, updated, participants)
      self.chat_number  = chat_number
      self.updated      = updated
      self.participants = participants
    end

    def to_s
      "#{chat_number} - #{participants.map(&:name).join(", ")}"
    end

    def self.fetch_all
      ascript_chats.map.with_index(1){|chat, i| from_ascript_chat(chat, i)}
    end

    def self.display_chats(limit)
      sort_by_updated(Chat.fetch_all).first(limit).map(&:to_s).join("\n")
    end

    def self.sort_by_updated(chats)
      chats.sort{|a,b| b.updated <=> a.updated }
    end

    def self.ascript_chats
      Appscript.app("Messages").chats.get()
    end

    def self.from_ascript_chat(chat, chat_number)
      new(chat_number, chat.updated.get(), participants_from_ascript_chat(chat))
    end

    def self.participants_from_ascript_chat(chat)
      chat.participants.get().map do |participant|
        Participant.from_ascript_participant(participant)
      end
    end

  end
end
