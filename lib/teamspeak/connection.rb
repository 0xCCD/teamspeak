module Teamspeak
  class Connection

    attr_accessor :connection, :config

    include ::Teamspeak::Query
    include ::Teamspeak::Commands

    def initialize options

      options.each do |k, v|
        @config ||= Teamspeak::Config.new
        @config.send(:"#{k}=", v)
      end

      @connection = Net::Telnet::new("Host" => @config.host, "Port" => @config.port)
      @connection.waitfor("Match" => /TS3\n(.*)\n/, "Timeout" => 3).match(/TS3/)

    end

  end
end