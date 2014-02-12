#!/usr/bin/env ruby
require "imsg/version"
require 'appscript'

def formatBuddies buddies
   retVal = ""
   count = 1
   buddies.each do |buddy|
      retVal += count.to_s + " - " +buddy.join(',') +"\n"
      count += 1
   end
   retVal
end

def is_i str
   !!(str =~ /^[-+]?[0-9]+$/)
end

str = ""
ARGV.each do |value|
  str +=value+" "
end
str = str.chomp(' ');
ARGV.clear
STDOUT.flush

imsg = Appscript.app("Messages")
a = imsg.chats.participants.get()
b = []
a.each do |v|
  names = []
  v.each do |buddy|
      names.push buddy.name.get()
  end
  b.push names
end
puts "\nWho would you like to send your message to?"
puts "(You can choose a number or type a buddy name/email)\n\n"
puts formatBuddies b

response = gets.chomp

if is_i response
  puts "Sending \'#{str}\'  to chat number #{response}"
  `osascript -e 'tell application "Messages" to send \"#{str}\" to item #{response.to_i} of text chats'`
else
  puts "Sending \'#{str}\' to buddy \'#{response}\'"
  `osascript -e 'tell application "Messages" to send \"#{str}\" to buddy \"#{response}\"'`
end
