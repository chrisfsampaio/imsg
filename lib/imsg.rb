#!/usr/bin/env ruby
require "imsg/version"
require 'appscript'

module ImsgHandler

	# Formats a list of buddies objects retrieved by Applescript into a readable list 
	# returns a formatted String
	def self.formatBuddies buddies
		formatedString = ""
		count = 1
		buddies.each do |buddy|
			formatedString += "  " + count.to_s + " - " + buddy.join(',') + "\n"
			count += 1
		end
		formatedString
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
		imsg = Appscript.app("Messages")
		participants = imsg.chats.participants.get()
		participantsByChat = []
		participants.each do |v|
			names = []
			v.each do |buddy|
				names.push buddy.name.get()
			end
			participantsByChat.push names
		end
		puts "\nWho would you like to send your message to?"
		puts "(You can choose a number or type a buddy name/email)\n\n"
		puts formatBuddies participantsByChat
	end

end