module Teamspeak
  class Config
    attr_accessor :host, :port, :username, :password, :debug, :debug_block

    def initialize
      @host = "127.0.0.1"
      @port = 10011
      @username = "serveradmin"
      @debug = false
      @debug_block = -> (c) { print c }
    end
  end
end