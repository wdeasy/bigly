require 'discordrb'
require 'humanize'

bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID'], prefix: '!'

puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.command :bigly do |_event, *args|
  msg = ''
  args.each do |arg|
    if (arg.count ":").to_i > 1
    	msg << "#{arg[arg.index(':')..arg.rindex(':')]}   "
    else
	  	arg.downcase!
	    arg.split("").each do |a|
	      if a =~ /[a-z]/
	       msg << ":regional_indicator_#{a}:"
	     	elsif a =~ /[0-9]/
	       msg << ":#{a.to_i.humanize}:"
	      elsif a == "#"
         msg << ":hash:" 
	      elsif a == "*"
         msg << ":asterisk:"
	     	else
	       msg << "#{a}"
	     	end
	    end
	    msg << '   '
    end
  end

  unless msg[0] == '/'
  	msg = msg[0..2000]
    msg[0..msg.rindex(':')]
  end
end

bot.run