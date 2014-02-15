#!/usr/bin/env ruby
require 'imsg/version'
require 'model/chat'

module ImsgHandler
	CHAT_DISPLAY_LIMIT = 15

	def self.display_chats(chats)
		sort_by_updated(chats).first(CHAT_DISPLAY_LIMIT).map(&:to_s).join("\n")
	end

	def self.sort_by_updated(chats)
		chats.sort{ |a, b| b.updated <=> a.updated }
	end

	# Check if a String is a integer number
	def self.is_i?(str)
		str =~ /\A\d+\z/
	end

	# Calls Applescript in order to trigger an iMessage message to a buddy
	# The buddy parameter accepts a String with either a chat number or a Buddy name
	def self.sendMessage message, buddy
		if is_i?(buddy)
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
		puts "\nTo whom would you like to send your message?"
		puts "(You can choose a number or type a buddy name/email)\n\n"
		puts display_chats(chats)
	end
end
