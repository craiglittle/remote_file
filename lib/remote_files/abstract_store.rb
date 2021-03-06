module RemoteFiles
  class AbstractStore
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end

    def options
      @options ||= {}
    end

    def []=(name, value)
      options[name] = value
    end

    def store!(file)
      raise "You need to implement #{self.class.name}#store!"
    end

    def retrieve!(identifier)
      raise "You need to implement #{self.class.name}#retrieve!"
    end

    def delete!(identifier)
      raise "You need to implement #{self.class.name}#delete!"
    end

    def url(identifier)
      raise "You need to implement #{self.class.name}#url"
    end

    def url_matcher
      raise "You need to implement #{self.class.name}:#url_matcher"
    end

    def file_from_url(url)
      matched = url_matcher.match(url)

      return nil unless matched

      file_identifier = matched[1]

      RemoteFiles::File.new(file_identifier, :stored_in => [identifier])
    end
  end
end
