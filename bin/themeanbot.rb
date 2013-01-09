#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'chatterbot/dsl'
require 'process_tweet'


# remove this to send out tweets
#debug_mode

#remove this to update the db
#no_update

#remove this to get less output when running
#verbose

# here's a list of users to ignore
blacklist "abc", "def"

replies do |tweet|
  script = ProcessTweet.reply_for(tweet)
  reply script, tweet unless script.nil?
end

#bot.client.direct_messages_received(:since_id => since_id).each do |m|
  #bot.client.direct_message_create("@_goyalankit","awesome")
  #client.unfollow(m.user.name)
#end

