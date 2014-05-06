require 'net/telnet'
require "teamspeak/version"
require "teamspeak/exceptions/query_failed"
require "teamspeak/config"
require "teamspeak/commands"
require "teamspeak/key_value"
require "teamspeak/query_response"
require "teamspeak/query"
require "teamspeak/connection"

module Teamspeak
  class << self
    def connect options, &block

      conn = Connection.new(options)

      conn.login
      if block_given?
        conn.instance_exec &block
      end
      conn

    rescue Net::OpenTimeout => ex
      warn "Connection timeout! Wrong host or port ?"
    rescue Errno::ECONNREFUSED => ex
      warn "Connection refused! Wrong host or port ?"
    end
  end
end
