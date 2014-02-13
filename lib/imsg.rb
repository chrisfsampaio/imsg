#!/usr/bin/env ruby
require "imsg/version"
require 'appscript'

module ImsgHandler
	CHAT_DISPLAY_LIMIT = 12

	class Chat
		attr_accessor :chat_number, :updated, :participants

		def initialize(chat_number, updated, participants)
			self.chat_number = chat_number
			self.updated = updated
			self.participants = participants
		end

		def to_s
			"#{chat_number} - #{participants.map(&:name).join(", ")}"
		end

		def self.fetch_all
			ascript_chats.map.with_index(1){ |chat, i| from_ascript_chat(chat, i) }
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

	class Participant
		attr_accessor :name

		def initialize(name)
			self.name = name
		end

		def self.from_ascript_participant(ascript_participant)
			self.new(ascript_participant.name.get())
		end
	end

	def self.display_chats(chats)
		sort_by_updated(chats).first(CHAT_DISPLAY_LIMIT).map(&:to_s).join("\n")
	end

	def self.sort_by_updated(chats)
		chats.sort{ |a, b| b.updated <=> a.updated }
	end

	# Check if a String is a integer number
	def self.is_i str
   		!!(str =~ /^[-+]?[0-9]+$/)
	end

	# Calls Applescript in order to trigger an iMessage message to a buddy
	# The buddy parameter accepts a String with either a chat number or a Buddy name
	def self.sendMessage message, buddy
		if is_i buddy
			puts "Sending \'#{message}\'  to chat number #{buddy}"
			`osascript -e 'tell application "Messages" to send \"#{message}\" to item #{buddy.to_i} of text chats'`
		else
			puts "Sending \'#{message}\' to buddy \'#{buddy}\'"
			`osascript -e 'tell application "Messages" to send \"#{message}\" to buddy \"#{buddy}\"'`
		end
	end

	# Shows the chat list along with their participants
	def self.showChatList
		chats = Chat.fetch_all
		puts "\nWho would you like to send your message to?"
		puts "(You can choose a number or type a buddy name/email)\n\n"
		puts display_chats(chats)
	end

end
