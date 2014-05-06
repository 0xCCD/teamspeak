module Teamspeak
  class KeyValue < Hash

    def methods
      super + self.keys
    end

    def respond_to? method_id, _private=false
      if self.keys.include?(method_id)
        return true
      else
        super
      end
    end

    def method_missing method_id, *args, &block
      if self.keys.include?(method_id)
        self[method_id]
      else
        super
      end

    end
  end
end