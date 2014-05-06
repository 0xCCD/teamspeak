module Teamspeak
  module Commands

    def login
      send_query("login client_login_name=#{@config.username} client_login_password=#{@config.password}")
    end

    def help method=nil
      if method.nil?
        puts send_query("help")
      else
        puts send_query("help #{method}")
      end
    end

    def method_missing method_id, *args, &block
      send_query("#{method_id} #{args.join(" ")}")
    rescue
      super
    end

  end
end