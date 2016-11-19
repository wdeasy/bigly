require 'discordrb'
require 'humanize'

bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID'], prefix: '!'

puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.command :bigly do |_event, *args|
  words = []
  args.each do |arg|
    word = ''
    unless (arg.count ":").to_i > 1
      arg.downcase!
      arg.split("").each do |a|
        if a =~ /[a-z]/
          word << ":regional_indicator_#{a}:"
        elsif a =~ /[0-9]/
          word << ":#{a.to_i.humanize}:"
        elsif a == "#"
          word << ":hash:" 
        elsif a == "*"
          word << ":asterisk:"
        else
          word << "#{a}"
        end
      end
    end
    words << word
  end

  msg = ''
  words.each do |word|
    if msg.length + word.length + 3 > 1999
      unless msg[0] == '/'
        _event.respond msg
        sleep(1)
      end
      msg = "#{word}   "
    else
      msg << "#{word}   "
    end 
  end
  unless msg[0] == '/' || msg == ''
    _event.respond msg
  end
end

bot.run