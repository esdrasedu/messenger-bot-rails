module Messenger
  module Bot
    class Transmitter
      
      attr_accessor :sender_id

      def initialize(sender)
        self.sender_id = sender
      end

      def reply(data)
        data = {
          recipient: {
            id: self.sender_id
          },
          message: data
        }
        Messenger::Bot::Request.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{Messenger::Bot::Config.access_token}", data)
      end

      def get_profile(fields = nil)
        fields ||= [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
        Messenger::Bot::Request.get("https://graph.facebook.com/v2.6/#{self.sender_id}?fields=#{fields.join(",")}&access_token=#{Messenger::Bot::Config.access_token}")
      end
    end
  end
end
