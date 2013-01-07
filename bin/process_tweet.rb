require 'wordnik'

class ProcessTweet
  class << self
    Wordnik.configure do |config|
      config.api_key = ENV['API_KEY']
    end

    def get_me_definition keyword
      results =  Wordnik.word.get_definitions(keyword, :use_canonical => true, :limit => 4, :source_dictionaries => 'all').collect{|i| i["text"] if i["text"].length < 100}.compact
      results.first
    end

    def reply_for tweet
      input = tweet.text.split()
      if input[0] == '@themeanbot'
        if input[1].downcase.include?("define")
          answer = ProcessTweet.get_me_definition(input[2])
          return answer.blank? ? self.script_for_failure(input[2]) : self.script_for_success(input[2], answer)
        else
          return self.script_for_hello
        end
      elsif tweet.text.include?('gotcha!') or tweet.text.include?('oops!') or tweet.text.include?('stopping by')
        return nil
      else
        return self.script_for_discussion
      end
    end

    def script_for_success keyword, answer
     "gotcha! #USER#, #{keyword} means --> #{answer}" 
    end

    def script_for_failure keyword
      "oops! #USER#, sorry I don't know what #{keyword} means, please check for spelling mistakes. master would be unhappy...:("
    end

    def script_for_hello
      scripts = ["hey #USER#, good to hear from you.", "hey #USER#, you miss me?", "hey there, #USER#"]
      scripts[rand(3)]
    end

    def script_for_discussion
      scripts = ["hmm... #USER#, seems like you are discussing about me.", "#USER#, I hope you are talking good about me...:)"]
      scripts[rand(2)]
    end
  end
end
