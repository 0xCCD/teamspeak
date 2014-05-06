module Teamspeak
  class QueryResponse

    attr_accessor :response, :struct

    def initialize _response

      @response = parse(_response)

      if !@response.match(/error id=0 msg=ok\n/)
        raise Teamspeak::Exceptions::QueryFailed.new(@response)
      end

    end

    def struct
      @struct ||= @response.split("|").
          map { |l| l.scan(/(\w*)=(.*?(?=\s\w+=|$))/) }.
          map { |l| l.inject(Teamspeak::KeyValue.new) { |c, v| c[v.first.to_sym] = v.last; c } }

      return @struct.first if @struct.size==1
      @struct
    end

    def to_str
      @response
    end

    def to_s
      to_str
    end

    def method_missing method_id, *args, &block
      struct[method_id].instance_eval do
        def method_missing method_id, *args, &block
          self[method_id]
        end
      end
    rescue
      super
    end

    private
    def parse _response
      {
          '\\\\' => "\\", # Backslash
          '\/' => "/", # Slash
          '\s' => " ", # Whitespace
          '\p' => "|", # Pipe
          '\a' => "\a", # Bell
          '\b' => "\b", # Backspace
          '\f' => "\f", # Formfeed
          '\n' => "\n", # Newline
          '\r' => "\r", # Carriage Return
          '\t' => "\t", # Horizontal Tab
          '\v' => "\v" # Vertical Tab
      }.each do |search, replace|
        _response.gsub!(search, replace)
      end

      _response

    end
  end
end