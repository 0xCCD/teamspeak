module Teamspeak
  module Query

    def send_query cmd, match=/error id=[0-9]* msg=(.*)\n/, timeout=3

      begin

        if @config.debug
          puts "#{cmd}\r"
          QueryResponse.new(@connection.cmd("String" => "#{cmd}\r", "Match" => match, "Timeout" => timeout, &@config.debug_block))
        else
          QueryResponse.new(@connection.cmd("String" => "#{cmd}\r", "Match" => match, "Timeout" => timeout))
        end

      rescue Net::ReadTimeout => ex
        puts "Timeout"
        puts ex.message
        raise Teamspeak::Exceptions::QueryFailed.new(cmd)
      end

    rescue Teamspeak::Exceptions::QueryFailed => ex
      puts ex.message
      puts ex.backtrace if @config.debug
    end

  end
end